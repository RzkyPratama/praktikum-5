const express = require("express")
const app = express()
const multer = require("multer") // untuk upload file
const path = require("path") // untuk memanggil path direktori
const fs = require("fs") // untuk manajemen file
const mysql = require("mysql")
const cors = require("cors")
const md5 = require("md5")
const Cryptr = require("cryptr")
const crypt = new Cryptr("140533601726") // secret key, boleh diganti kok

validateToken = () => {
    return (req, res, next) => {
        // cek keberadaan "Token" pada request header
        if (!req.get("Token")) {
            // jika "Token" tidak ada
            res.json({
                message: "Access Forbidden"
            })
        } else {
            // tampung nilai Token
            let token  = req.get("Token")
            
            // decrypt token menjadi id_user
            let decryptToken = crypt.decrypt(token)

            // sql cek id_user
            let sql = "select * from user where ?"

            // set parameter
            let param = { id_user: decryptToken}

            // run query
            dbs.query(sql, param, (error, result) => {
                if (error) throw error
                 // cek keberadaan id_user
                if (result.length > 0) {
                    // id_user tersedia
                    next()
                } else {
                    // jika user tidak tersedia
                    res.json({
                        message: "Invalid Token"
                    })
                }
            })
        }

    }
}

app.use(express.static(__dirname));
app.use(express.json())
app.use(express.urlencoded({extended: true}))
app.use(cors())

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        // set file storage
        cb(null, './image');
    },
    filename: (req, file, cb) => {
        // generate file name 
        cb(null, "image-"+ Date.now() + path.extname(file.originalname))
    }
})

let upload = multer({storage: storage})

const db = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "olshop"
})

const dbs = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "pelanggaran_siswa"
})
// endpoint untuk menambah data barang baru
app.post("/barang", upload.single("image"), (req, res) => {
    // prepare data
    let data = {
        nama_barang: req.body.nama_barang,
        harga: req.body.harga,
        stok: req.body.stok,
        deskripsi: req.body.deskripsi,
        image: req.file.filename
    }

    if (!req.file) {
        // jika tidak ada file yang diupload
        res.json({
            message: "Tidak ada file yang dikirim"
        })
    } else {
        // create sql insert
        let sql = "insert into barang set ?"

        // run query
        db.query(sql, data, (error, result) => {
            if(error) throw error
            res.json({
                message: result.affectedRows + " data berhasil disimpan"
            })
        })
    }
})

// endpoint untuk mengubah data barang
app.put("/barang", upload.single("image"), (req,res) => {
    let data = null, sql = null
    // paramter perubahan data
    let param = { kode_barang: req.body.kode_barang }

    if (!req.file) {
        // jika tidak ada file yang dikirim = update data saja
        data = {
            nama_barang: req.body.nama_barang,
            harga: req.body.harga,
            stok: req.body.stok,
            deskripsi: req.body.deskripsi
        }
    } else {
        // jika mengirim file = update data + reupload
        data = {
            nama_barang: req.body.nama_barang,
            harga: req.body.harga,
            stok: req.body.stok,
            deskripsi: req.body.deskripsi,
            image: req.file.filename
        }

        // get data yg akan diupdate utk mendapatkan nama file yang lama
        sql = "select * from barang where ?"
        // run query
        db.query(sql, param, (err, result) => {
            if (err) throw err
            // tampung nama file yang lama
            let fileName = result[0].image

            // hapus file yg lama
            let dir = path.join(__dirname,"image",fileName)
            fs.unlink(dir, (error) => {})
        })

    }

    // create sql update
    sql = "update barang set ? where ?"

    // run sql update
    db.query(sql, [data,param], (error, result) => {
        if (error) {
            res.json({
                message: error.message
            })
        } else {
            res.json({
                message: result.affectedRows + " data berhasil diubah"
            })
        }
    })
})

// endpoint untuk menghapus data barang
app.delete("/barang/:kode_barang", (req,res) => {
    let param = {kode_barang: req.params.kode_barang}

    // ambil data yang akan dihapus
    let sql = "select * from barang where ?"
    // run query
    db.query(sql, param, (error, result) => {
        if (error) throw error
        
        // tampung nama file yang lama
        let fileName = result[0].image

        // hapus file yg lama
        let dir = path.join(__dirname,"image",fileName)
        fs.unlink(dir, (error) => {})
    })

    // create sql delete
    sql = "delete from barang where ?"

    // run query
    db.query(sql, param, (error, result) => {
        if (error) {
            res.json({
                message: error.message
            })
        } else {
            res.json({
                message: result.affectedRows + " data berhasil dihapus"
            })
        }      
    })
})

// endpoint ambil data barang
app.get("/barang", (req, res) => {
    // create sql query
    let sql = "select * from barang"

    // run query
    db.query(sql, (error, result) => {
        if (error) throw error
        res.json({
            data: result,
            count: result.length
        })
    })
})

app.listen(8000, () =>{
    console.log("Server run on port 8000");
})

// endpoint siswa
app.get("/siswa",validateToken(), (req,res) =>{
    let sql = "select * from siswa"
    dbs.query(sql, (err, result) => {
        if (err) {
            throw err
        }
        else{
            let response = {
                count: result.length,
                siswa: result
            }
        
            res.setHeader("Content-Type","application/json")
            res.send(JSON.stringify(response))
        }
    })

})

// endpoint login user (authentication)
app.post("/user/auth", (req, res) => {
    // tampung username dan password
    let param = [
        req.body.username, //username
        md5(req.body.password) // password
    ]
    
    // create sql query
    let sql = "select * from user where username = ? and password = ?"

    // run query
    dbs.query(sql, param, (error, result) => {
        if (error) throw error

        // cek jumlah data hasil query
        if (result.length > 0) {
            // user tersedia
            res.json({
                message: "Logged",
                token: crypt.encrypt(result[0].id_user), // generate token
                data: result
            })
        } else {
            // user tidak tersedia
            res.json({
                message: "Invalid username/password"
            })
        }
    })
})

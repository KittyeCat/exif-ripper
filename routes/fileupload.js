var express = require('express');
var router = express.Router();
var formidable = require('formidable');
const { exec } = require('child_process');


router.post('/', function(req, res, next) {
    var form = new formidable.IncomingForm();
    form.parse(req, function (err, fields, files) {
        var filepath = files.filetoupload.filepath;

        var uz_command = 'unzip ' + filepath + ' -d /app/public/files/unzipped/';
        exec(uz_command, (err)=> {
            if (err) throw err;
        })
        // if (err) {
        //     next(err);
        //     return;
        //   }
        // res.json({ fields, files });
        res.render('uploaded', { title: 'Exif-Ripper' });
        // } else {
        //     res.render('uploadfailed', { title: 'Exif-Ripper' })
        // }; 
    });
  });

  module.exports = router;
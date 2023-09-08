const express = require('express');
const auth=require('./routes/auth');
const carMan=require('./routes/carMan');
const tripMan=require('./routes/tripMan');
const home=require('./routes/home');
const profile=require('./routes/profileMan');
const mongoose=require('mongoose');
const bodyParser = require('body-parser');
mongoose.connect(
    'mongodb+srv://coadmin:PuAxQEkfvLz3Npk7@cluster0.9mskojx.mongodb.net/',{ useNewUrlParser: true,useUnifiedTopology: true ,useFindAndModify: false },
    (err) => {
     if(err) console.log(err) 
     else console.log("mongdb is connected");
    }
  );
app=express();
app.use(express.json());
app.use('/auth',auth);
app.use('/carMan',carMan);
app.use('/trip',tripMan);
app.use('/home',home);
app.use('/profile',profile);
app.get('/',(req,res)=>{
    res.send('TEST');
});
app.listen(3030,()=>{
    console.log('Server is online');
});

app.use(bodyParser.json());

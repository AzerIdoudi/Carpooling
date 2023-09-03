const router=require('express').Router();
const users=require('../userList');
const cars=require('../carList');
const mongoose=require('mongoose')

router.get('/drivers',async (req,res)=>{
    let drivers=await users.find({status:'Driver'});
    res.status(200).send(
        drivers
    )
});
router.get('/carList',async (req,res)=>{
    let car= await cars.find({});
    res.status(200).send(
        car
    )
});

module.exports=router;
const router=require('express').Router();
const users=require('../userList');
const mongoose=require('mongoose')

router.get('/drivers',async (req,res)=>{
    let drivers=await users.find({status:'Driver'});
    res.status(200).send(
        drivers
    )
});
module.exports=router;
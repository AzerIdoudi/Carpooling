const router=require('express').Router();
const users=require('../userList');
const {check,validationResult}=require('express-validator');
const bcrypt=require('bcrypt');

router.post("/public",
[
    check("newName","Please enter a valid name")
        .isLength({min:6}),
        check("newCity","Please enter a valid city")
        .isLength({min:4}),
    ]
, async(req,res)=>{
    const {newName,newCity,userID}=req.body;
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }
    else{
    let user=await users.findOneAndUpdate({userID:userID},{"fullName":newName,"city":newCity});
    res.status(200).send(
        user)}
});
router.post("/email",
[
    check("newEmail","Please enter a valid Email")
        .isEmail({min:6}),
    ]
, async(req,res)=>{
    const {newEmail,oldPasswordEmail,userID}=req.body;
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }
    else{
    let user= await users.findOne({userID:userID});
    let isMatch= await bcrypt.compare(oldPasswordEmail,user.password);
    if (isMatch==false){
        res.status(400).send("invalid password")
    }
    else{
    user=await users.findOneAndUpdate({userID:userID},{"email":newEmail});
    res.status(200).send(
        user)}}
});
router.post("/password",
[
    check("newPassword","New password must be longer than 5 characters")
        .isLength({min:6}),
    ]
, async(req,res)=>{
    const {newPassword,confirmNewPassword,oldPassword,userID}=req.body;
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }
    else{
    let user= await users.findOne({userID:userID});
    let isMatch= await bcrypt.compare(oldPassword,user.password);
    if (isMatch==false){
        res.status(400).send("invalid password")
    }
    else{
    let newHashedPassword= await bcrypt.hash(newPassword,10);
    user=await users.findOneAndUpdate({userID:userID},{"password":newHashedPassword});
    res.status(200).send(
        user)}}
});

module.exports=router;
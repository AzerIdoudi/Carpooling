const router=require('express').Router();
const users=require('../userList');
const {check,validationResult}=require('express-validator');
const cars=require('../carList');
const mongoose=require('mongoose');

router.post("/notDriver", async(req,res)=>{
    const {owner}=req.body;
    const token=JSON.parse(Buffer.from(owner.split('.')[1], 'base64').toString());

    let user=await users.findOneAndUpdate({email:token.email},{"status":"Passenger"});
    res.status(200).send(
        user)
})


router.post("/createCar",[
    check("mark","Please enter a valid car Mark")
        .isLength({min:6}),
    check("model","Please provide a valid car Model")
        .isLength({min:6}),
    check("condition","please enter a valid Condition")
        .isLength({min:3})
    ]
,async (req,res)=>{
    const {mark,model,condition,owner}=req.body;
    const token=JSON.parse(Buffer.from(owner.split('.')[1], 'base64').toString());
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }
    else{
    cars.create({
        mark,
        model,
        condition,
        owner:token.email
    });
    let user=await users.findOneAndUpdate({email:token.email},{'status':'Driver'});
    res.status(200).send(
        user)
}
});

module.exports=router;
const router=require('express').Router();
const users=require('../userList');
const {check,validationResult}=require('express-validator');
const cars=require('../carList');

router.post("/notDriver", async(req,res)=>{
    const {owner}=req.body;
    let user=await users.findOneAndUpdate({email:owner},{"status":"Passenger"});
    res.status(200).send(
        user)
});
router.post("/deleteCar", async(req,res)=>{
    const {carID}=req.body;
    let car=await cars.findOneAndDelete({carID:carID});
    res.status(200).send(
        console.log(carID))
});
router.post("/createCar",[
    check("mark","Please enter a valid car Mark")
        .isLength({min:3}),
    check("model","Please provide a valid car Model")
        .isLength({min:3}),
    check("condition","please enter a valid Condition")
        .isLength({min:3})
    ]
,async (req,res)=>{
    const {mark,model,condition,owner}=req.body;
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }
    else{
    cars.create({
        carID:Date.now().toString(),
        mark,
        model,
        condition,
        owner:owner
    });
    let user=await users.findOneAndUpdate({email:owner},{'status':'Driver'});
    res.status(200).send(
        user)
}
})

module.exports=router;
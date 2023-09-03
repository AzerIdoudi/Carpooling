const router=require('express').Router();
const trip=require('../tripList');
const users=require('../userList');

const {check,validationResult}=require('express-validator');

router.post("/request",[
    check("destination","Please provide a valid destination")
        .isLength({min:4}),
    check("driver","Please provide a valid driver email")
        .isEmail(),
    check("car","Please provide a valid car model")
        .isLength({min:3})
    ], async(req,res)=>{
        const {destination,driver,car,dateTime,token}=req.body;
    const passenger=JSON.parse(Buffer.from(token.split('.')[1], 'base64').toString());
    const errors=validationResult(req);
    if (!errors.isEmpty()){

        return res.status(400).send(
            errors.array()[0].msg
        )
    }else{
        let user= await users.findOne({email:passenger.email});
        if(!user){
            res.status(400).send('Driver Email not found');
                }
                else if(dateTime=='2001/2/20    0 : 0'){
                    res.status(400).send('Choose Date and Time')
                }
        else{
        trip.create({
            destination,
            driver,
            car,
            dateTime,
            passenger:passenger.email,
            status:'Pending'
        });
        res.status(200).send(
            'Request sent!')}
    }}
);
router.get('/ptrip',async (req,res)=>{
    let trips= await trip.find({});
    res.status(200).send(
        trips
    )
});

module.exports=router;
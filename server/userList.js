const mongoose=require('mongoose');

const usersSchema= mongoose.Schema({
  userID:{
    type:String,
  }, 
  fullName:{
    type:String,
  },  
  email:{
    type:String,
  },  
  city:{
    type:String,
  },  
  password:{
    type:String,
  },  
  status:{
    type:String
  }
});
module.exports=mongoose.model('users',usersSchema);
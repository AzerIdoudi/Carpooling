const mongoose=require('mongoose');

const usersSchema= mongoose.Schema({
  destination:{
    type:String,
  },  
  driver:{
    type:String,
  },  
  car:{
    type:String,
  },  
  dateTime:{
    type:String,
  },
  passenger:{
    type:String,
  },
  status:{
    type:String,
  },

});
module.exports=mongoose.model('trips',usersSchema);
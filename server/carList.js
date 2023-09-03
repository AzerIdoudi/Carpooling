const mongoose=require('mongoose');

const usersSchema= mongoose.Schema({
  carID:{
    type:String,
  }, 
  mark:{
    type:String,
  },  
  model:{
    type:String,
  },  
  condition:{
    type:String,
  },
  owner:{
    type:String,
  }
});
module.exports=mongoose.model('cars',usersSchema);
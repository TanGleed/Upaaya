const mongoose= require("mongoose");

const Schema= mongoose.Schema;

const Profile= Schema({
    name: String,
    DOB: String,
    contact:
    {type: String,
    required: true,
    unique: true
    },
    address: String,
    img:{
        type: String,
        default:""
    }
},
{
    timestamp: true,
});

module.exports= mongoose.model("Profile", Profile);
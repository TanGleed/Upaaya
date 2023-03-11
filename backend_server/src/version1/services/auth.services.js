const { user }=require("../../models/auth.model")
const bcrypt = require("bcryptjs");
const { response } = require("express");

//singup 
async function register(params ,callback)
{
    //validates email
    if (params.email==undefined)
    {
        return callback( {
            message : "Email Required"
        });
    }
    //checks user with same email if any
    let userRegistered = await user.findOne({email:params.email});
    
    if(userRegistered){
        return callback(
            {
                message:"Email Already Registered",
            }
        );
    }
    //encrptying password
    const salt =bcrypt.genSaltSync(10);
    params.password =bcrypt.hashSync(params.password,salt);
    const Userschema = new user (params);
    Userschema .save().then(
        (response)=>
        {
            return callback(null ,response);
        }
    ).catch(
        (error)=>
        {
        return callback(error);
        }
    );
}

module.exports ={
    register,
    
};
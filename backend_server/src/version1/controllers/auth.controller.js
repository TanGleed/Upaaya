const e = require("express");
const  authservice  = require("../services/auth.services");


//signup
exports.register=(req,res,next)=>{
    authservice.register(
        req.body,
        (error,result)=>
        {
            if(error)
            {
                return next(error);
            }
            else 
            {
                return res.status(200).send(
                    {
                    message:"Success",
                    data:result,
                    }
                );
            }
        }
    );
};


//unique email
exports.uniqueemail=(req,res,next)=>{
    authservice.uniqueemail(
        req.body,
        (error,result)=>
        {
            if(error)
            {
                
                return next(error);
            }
            else
            {
                return res.status(200).send(
                    {
                        message:"Success",
                        data:result,
                    }
                );
            }
        }
    );
}

//send otp
exports.sendOTP =(req,res,next)=>{
    authservice.sendOTP(
    req.body,
    (error,result)=>
    {
        if(error)
        {
            return next(error);
        }
        else
        {
            return res.status(200).send(
                {
                    message:"Success",
                    data:result
                }
            )
        }
    }
    );
}

//verify otp
exports.verifyOTP = (req,res,next)=>{
    authservice.verifyOTP(
        req.body,
        (error,result)=>
        {
            
            if(error)
            {
                if(error.message== "OTP Expired")
                {
                    return res.status(410).send(
                    {
                        message:"OTP Expired",
                        data:result
                    }
                    )
                 }
                else if(error.message=="Invalid OTP")
                {
                return res.status(409).send(
                    {
                        message: "Invalid OTP",
                        data:result
                    }
                )
                }
                else
                {
                    return next(error);
                }
            }
        else
        {
                return res.status(200).send(
                    {
                        message:"Success",
                        data:result
                    }
                )
        }
        }
    )
}
 

//user login
exports.login =(req,res,next)=>{
    authservice.login(
        req.body,
        (error,result)=>{
            if(error)
            {
                if(error.message=="Email Not Registered")
                {
                    return res.status(404).send(
                        {
                            message:"Email Not Registered",
                            data:result,
                        }
                    )
                }
                else if(error.message=="Invalid Password")
                {
                    return res.status(401).send(
                        {
                            message:"Invalid Password",
                            data:result,
                        }
                    )
                }
                else 
                {
                    return next(error);
                }
            }
            else
            {
                return res.status(200).send(
                    {
                        message:"Success",
                        data:result
                    }
                )
            }
        }
    )
}

//resetpass
exports.resetpassword =(req,res,next)=>
{
    authservice.resetpassword(
        req.body,
        (error,result)=>
        {
            if(error)
            {
                return next(error);
            }
            else
            {
                return res.status(200).send(
                    {
                        message:"Success",
                        data:result
                    }
                )
            }
        }
    );
}



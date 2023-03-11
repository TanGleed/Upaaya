const   authservice  = require("../services/auth.services");


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


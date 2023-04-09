const { user }=require("../../models/auth.model");
const { otp } =require("../../models/otp.model");
const auth   = require("../middleware/auth.middleware");
const bcrypt = require("bcryptjs");
const otpGenerator = require("otp-generator");
const nodemailer = require("nodemailer");



//singup 
async function register(params ,callback)
{
    
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

//email uniqueness
async function uniqueemail(params,callback)
{
    user.findOne({email:params.email}).then(
        (response)=>
        {
            
            return callback(response);       
        }
    ).catch(
        (error)=>
        {
            
            return callback(error);
        }
    )
    
}

//sendotp
async function sendOTP(params,callback)
{
    await otp.findOneAndDelete(
        {
            email:params.email,
        }
    )
    //creating otp 
    const OTP =otpGenerator.generate(
        4,
        {
            lowerCaseAlphabets: false,
            upperCaseAlphabets:false,
            specialChars: false
        }
    );
    const tmout = 2*60*1000;
    //const data = params.email+OTP;
    //const hashOTP =crypto.createHmac("sha256",key).update(data).digest("hec");
    const salt =bcrypt.genSaltSync(10);
    const hashOTP =bcrypt.hashSync(OTP,salt);
    const newOTP =  otp({
        email:params.email,
        otp :hashOTP,
        createdat :Date.now(),
    });
    newOTP.save();
    //Mail template
    const mailOptions ={
        from :"sudeepbhattarai806@gmail.com",
        to : params.email, 
        subject: "Verify Your Email" ,
        html:`<!doctype html>
        <!doctype html>
        <html lang="en-US">
        
        <head>
            <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
            <title>Verfiy Your Email</title>
            <meta name="description" content="Verfiy Your Email">
            <style type="text/css">
                a:hover {text-decoration: underline !important;}
            </style>
        </head>
        
        <body marginheight="0" topmargin="0" marginwidth="0" style="margin: 0px; background-color: #f2f3f8;" leftmargin="0">
            <!--100% body table-->
            <table cellspacing="0" border="0" cellpadding="0" width="100%" bgcolor="#f2f3f8"
                style="@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;">
                <tr>
                    <td>
                        <table style="background-color: #f2f3f8; max-width:670px;  margin:0 auto;" width="100%" border="0"
                            align="center" cellpadding="0" cellspacing="0">
                            <tr>
                                <td style="height:80px;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                  
                                    <img width="60" src="https://i.postimg.cc/2j74BXYB/Logo.png" title="logo" alt="logo">
                                  </a>
                                </td>
                            </tr>
                            <tr>
                                <td style="height:20px;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0"
                                        style="max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);">
                                        <tr>
                                            <td style="height:40px;">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td style="padding:0 35px;">
                                                <h1 style="color:#1e1e2d; font-weight:500; margin:0;font-size:32px;font-family:'Rubik',sans-serif;">You have
                                                    requested to verify your mail</h1>
                                                <span
                                                    style="display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;">${OTP}</span>
                                                <p style="color:#455056; font-size:15px;line-height:24px; margin:0;">
                                                    We have send you OTP(One Time Password). Please Enter the OTP and proceed futher .OTP Expires in 2 minutes 
                                                </p>
                                              
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height:40px;">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            <tr>
                                <td style="height:20px;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="text-align:center;">
                                    <p style="font-size:14px; color:rgba(69, 80, 86, 0.7411764705882353); line-height:18px; margin:0 0 0;">&copy; <strong>Upaaya</strong></p>
                                </td>
                            </tr>
                            <tr>
                                <td style="height:80px;">&nbsp;</td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!--/100% body table-->
        </body>
        </html>
           `,
    }

    //defining transporter
    let transporter = nodemailer.createTransport({
        service: 'gmail',
    
        auth:
        {
          user: "sudeepbhattarai1792@gmail.com",
          pass: "bjlxrlgfsndcglec",
        }
      });
    
    //sending mail
    transporter.sendMail(mailOptions,function(error,info)
    {
        if(error)
        {
            console.log("error");
            
           return callback(error);

        }
        else
        {
           
           return callback (null,hashOTP);
        }
    });
    
}

//verify otp
async function verifyOTP(params,callback)
{
    try{
        let email =params.email;
        let OTP= params.otp;
        if(!(OTP))
        {
            throw Error("Empty OTP");
        }
        else
        {
            const otprecord = await otp.findOne(
                {
                    email: email
                }
            );
            const expiry  = otprecord.createdat;
            const hashOTP = otprecord.otp;
            const tmout = 2*60*1000;
            const currenttime =Date.now();
            if(currenttime-expiry>tmout)
            {
                await otp.findOneAndDelete(
                    {
                        email:email
                    }
                )
                throw new Error("OTP Expired");
                
            }
            else
            {
                const isvalidOTP =await bcrypt.compare(OTP,hashOTP);
                if(!isvalidOTP)
                {

                    throw new Error("Invalid OTP");
                }
                else
                {
                    await otp.findOneAndDelete(
                        {
                            email:email
                        }
                    )
                    return callback (null,hashOTP);
                }
            }
        }

    }catch (error)
    {
        
        return callback(error);
    }
}
//logim
async function login (
    params ,callback
)
{
    try
    {
        let userschema = await user.findOne({email:params.email});
        
        if(userschema!=null)
        {
            
            const hashedpass =userschema.password;
            if(bcrypt.compareSync(params.password,hashedpass))
            {
                let usertoken = auth.generateToken(userschema.toJSON());
                return callback(null,{ ...userschema.toJSON(),usertoken});
            }
            else
            {
                throw new Error("Invalid Password");
            }
        }
        else
        {
            throw Error("Email Not Registered");
        }

        
    }
    catch(error)
    {
        return callback(error);
    }
}

async function resetpassword(
    params,
    callback
)
{
    try
    {       
     //encrptying password
    const salt =bcrypt.genSaltSync(10);
    params.password =bcrypt.hashSync(params.password,salt); 
    //updating
    const updated= await user.findOneAndUpdate(
        {
        email:params.email
        },
        {
            $set:
            {
                password: params.password
            }
        },
        {
            lean:true
        }

    );
    if(updated)
    {
        return callback(null ,"Successful");
    }
    else
    {
        throw Error("Unsuccessful")
    }
        

    }catch(error)
    {
        return callback(error);
    }
}
module.exports ={
    register,
    uniqueemail,
    sendOTP,
    verifyOTP,
    login,
    resetpassword,
};
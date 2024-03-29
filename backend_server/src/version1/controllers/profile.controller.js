
const profileservice= require("../services/profile.services")
const upload = require("../middleware/profile.middleware");

exports.addProfile=(req,res,next)=>{
  profileservice.addProfile(
    
      req.body,
      (error,result)=>
      {
          if(error)
          {
              return res.json(error);
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
exports.uploadimage= (req,res,next)=>{

    upload(req, res, function (err) {
        console.log(req.file);
        if (err) {
          console.log(err);
          next(err);
        } else {
            console.log(req.file);
            const path =
            req.file != undefined ? req.file.path.replace(/\\/g, "/") : "";
        const user=
        {
            contact:req.body.contact,
            img:path != "" ? "/" + path : "",
        } ;
        
            
        contact =req.body.contact;
          profileservice.updateProfileImage(user, (error, results) => {
            if (error) {
              console.log(error);
              return next(error);
            } else {
              return res.status(200).send({
                message: "Succes",
                data: results,
              });
            }
          });
        }
      });
}

exports. getUserProfile = (req,res,next)=>{
    profileservice.getUserProfile(
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
exports.updateuserprofile = (req ,res ,next)=>{
    profileservice.updateuserprofile(
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
// exports.updateuserprofile=(req,res,next)=>{
//     profileservice.updateuserprofile(
//         req.body,
//         error,result=>
//         {
//             if(error)
//             {
//                 return next(error);
//             }
//             else
//             {
//                 return res.status(200).send(
//                     {
//                         message:"Success",
//                         data:result,
//                     }
//                 );
//             }
            
//         }
//     );
   
// }
// const updateProfileImage = async (req, res) => {
//   try {
//     const contact = req.body.contact;
//     const imagePath = req.file.path;
//     const updated = await profileServices.updateProfileImage(
//       contact,
//       imagePath
//     );
//     return res.json({ msg: "Image successfully updated", data: updated});
//   } catch (err) {
//     return res.status(400).json({ err: err.message });
//   }
// };

// const checkProfile= (req, res)=>{
//     profile.findOne({contact:req.decoded.contact}, (err, result)=>{
//       if(err) return res.json({err:err});
//       else if(result==null){
//         return res.json({status:false});
//       }
//       else{
//         return res.json({status:true});
//       }
//     })
// }

// module.exports = {
//   updateProfileImage,
//   checkProfile
// };


const profileservice= require("../services/profile.services")


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

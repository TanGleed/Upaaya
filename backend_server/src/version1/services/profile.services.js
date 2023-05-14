const { profile } =require("../../models/profile.model");




async function addProfile(params, callback) {

  const profileschema = new profile(params);

  profileschema.save()
    .then((response) => {
      return callback(null, response);
    })
    .catch((error) => {
      return callback(error);
    });
}

async function updateToken(usertoken,email)
{
  try
  {
    await profile.findOneAndUpdate(
      {
        contact : email,
      },
      {
        $set:{
          usertoken:usertoken,
        },
      },
      {
      new:true
      }
    )
    
  }
  catch(error) {
    return error;
  }
}

async function updateuserprofile(params,callback)
{
  try{
    const updated = await profile.findOneAndUpdate(
      {
        contact:params.contact
      },
      {
        $set: {
          name:params.name,
          DOB:params.DOB,
          address:params.address
        },
      },
      {
        new: true,
      }
    );
    if(updated)
    {
      return callback(null,updated);
    }
    else
    {
      throw Error('Failed');
    }
  }
  catch (error)
  {
    return callback(error);
  }
}



async function getUserProfile  (params,callback)
{
  
  try{
    let userRegistered =await profile.findOne({
      contact: params.contact,
    })
  if(userRegistered)
  {
  return callback(null,{...userRegistered.toJSON()});
  }
  else{
    throw Error('null');
  }
}
catch (e)
{
  return callback(e);
}
}
// const addProfile = async (name, DOB, contact, address) => {
//   const profile = Profile({
//     name: name,
//     DOB: DOB,
//     contact: contact,
//     address: address
//   });
//   try {
//     print(err);
//     await profile.save();
//     return "Profile successfully stored";
//   } catch (err) {
//     throw new Error(err.message);
//   }
// };


 async function updateProfileImage (params,callback)  {
  try {
    console.log(params.img);
    const updated = await profile.findOneAndUpdate(
      { contact: params.contact },
      { $set: 
        { 
          img:params.img
        } 
      },
      { new: true }
    );
    // console.log(updated);
    return callback(null,updated);
  } catch (err) {
    return callback(err);
  }
};
module.exports = {
  addProfile,
  getUserProfile,
  updateProfileImage,
  updateToken,
  updateuserprofile,
};

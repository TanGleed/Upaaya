const mongoose = require("mongoose");

const profile = mongoose.model(
    "Profile",
    mongoose.Schema(
        {
            usertoken:
            {
                type: String,
                unique: true,
                required: true,
            },
                name: String,
            DOB:
            {
                type:String,
            },
            contact:
            {
                type: String,
                required: true
            },
            address:
            {
                type:String,
            } ,
            img: 
            {
                type: String,
                default: ""
            }
        },
        {
            toJSON:
            {
                transfrom:
                    (doc, ret) => {
                        ret.userId = ret.id.toString();
                        delete ret._id;
                        delete ret._v;
                        delete ret.password;
                    },
            },
        },
        {
            timestamp: true,
        }

    )
)

module.exports =
{
    profile,
}

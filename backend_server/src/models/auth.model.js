const mongoose = require("mongoose");

const user = mongoose.model(
    "User",
    mongoose.Schema(
        {
            name:
            {
                type: String,
                required: true,
                min: 5,
                max: 25,
                trim: true,
            },

            email:
            {
                type: String,
                required: true,
                unique: true,
                trim: true,
                match:
                    /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,

            },

            password:
            {
                type: String,
                required: true,
                trim: true,
            },

            contact:
            {
                type: String,
                default: "",
                trim: true,
            },
            

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
            timestamps: true
        }
    )
)


module.exports = {
    user, 

};
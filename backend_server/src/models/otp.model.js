const mongoose = require("mongoose");
const otp =mongoose.model (
    "otp",
    mongoose.Schema(
        {
            email:
            {
                type: String,
                required: true,
                unique: true,
                trim: true,
                match:
                    /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/,

            },
            otp :
            {
                type: String,
                max: 4,
                min:4,
            },
            
            createdat:Date,
        }
    )
);
module.exports =
{
    otp,
}

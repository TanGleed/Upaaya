const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const jobSchema = new Schema({
    title: {
        type: String,
        required: true,
    },
    location: {
        type: String,
        required: true,
    },
    description: String,
    tags: [String],
    additionalInfo: String,
    media: String,
});



module.exports = mongoose.model('Job', jobSchema);
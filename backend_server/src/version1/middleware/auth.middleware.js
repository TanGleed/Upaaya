const jwt = require("jsonwebtoken");

const Token = "RAND_KEY";

function authToken(req, res, next) {
  const authHeader = req.headers.usertoken;
  console.log(authHeader);
  const token = authHeader.slice(7, authHeader.length);
  console.log(token);
  if (!token) {
    return res.status(403).send({
      message: "Token Empty",
    });
  }

   jwt.verify(token, Token, (err, decoded) => { //(err,user)
    if (err) {
      return res.status(401).send({
        message: "Unauthorized",
      });
    }
    console.log(decoded);
   // req.user = user.data;
    req.decoded= decoded;
    next();
  });
}

function generateToken(userModel) {
  return jwt.sign(
    {
      id:userModel._id,
    },
    Token,
    {
      expiresIn: "2h",
    }
  );
}

module.exports =
{
    authToken,
    generateToken
};

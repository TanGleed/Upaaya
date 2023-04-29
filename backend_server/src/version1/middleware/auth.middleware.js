const jwt = require("jsonwebtoken");

const Token = "RAND_KEY";

function authToken(req, res, next) {
  const authHeader = req.headers["authorization"];
  console.log(authHeader);
  const token = authHeader.slice(7, authHeader.length);

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
   // req.user = user.data;
    req.decoded= decoded;
    next();
  });
}

function generateToken(userModel) {
  return jwt.sign(
    {
      data: userModel,
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

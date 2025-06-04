const express = require("express");
const User = require("../models/user");
const bcryptjs = require('bcryptjs');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

//회원가입
authRouter.post('/api/signup', async (req, res) => {
  //사용자로부터 데이터 받음
  try{
    const {name, email, password, region} = req.body;

    const existingUser = await User.findOne({ email });

    if (existingUser){
      return res
      .status(400)
      .json({ msg: '이미 같은 이메일을 사용하는 이용자가 존재합니다.' });
  }

  const hashedPassword = await bcryptjs.hash(password, 8);

  let user = new User({
    email,
    password: hashedPassword,
    name,
    region,
  });
  user = await user.save();
  res.json(user);
  } catch(e){
    res.status(500).json({ error: e.message });
  }
});

//sign in route
//exercise
authRouter.post('/api/signin', async (req, res)=>{
  try{
    const {email, password} = req.body;

    const user = await User.findOne({ email });
    if(!user) {
      return res
        .status(400)
        .json({msg: '이메일을 정확하게 입력해주세요.'});
    }
    const isMatch = await bcryptjs.compare(password, user.password);
    if(!isMatch){
      return res
        .status(400)
        .json({msg: '비밀번호를 정확하게 입력해주세요.'});
    }

    const token = jwt.sign({id: user._id}, "passwordKey");
    res.json({token, ...user._doc});
  } catch(e){
    res.status(500).json({error: e.message});
  }
});

authRouter.post('/tokenIsValid', async (req, res)=>{
  try{
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);
    const verified = jwt.verify(token, 'passwordKey');
    if(!verified) return res.json(false);

    const user = await User.findById(verified.id)
    if(!user) return res.json(false);
    res.json(true);
  } catch(e){
    res.status(500).json({error: e.message});
  }
});

//get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});
module.exports = authRouter;
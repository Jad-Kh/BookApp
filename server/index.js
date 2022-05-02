const express = require('express');
const app = express();

const PORT = process.env.PORT || 5050

const dotenv = require('dotenv');
const helmet = require('helmet');
const morgan = require('morgan');
const multer = require('multer');

dotenv.config();

app.use(express.json());
app.use(helmet());
app.use(morgan("dev"));

const authRoute = require('../server/routes/authRoute');
const userRoute = require('../server/routes/userRoute');
const bookRoute = require('../server/routes/bookRoute');
const listRoute = require('../server/routes/listRoute');

app.use("/api/auth", authRoute);
app.use("/api/users", userRoute);
app.use("/api/books", bookRoute);
app.use("/api/lists", listRoute);

app.listen(PORT, () => {
    console.log(`Running Backend on Port ${PORT}`);
});
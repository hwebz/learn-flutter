const nodemailer = require('nodemailer');

const sendMail = async (
  email,
  subject,
  body,
  successMessage,
  errorMesage
) => {
  const transporter = nodemailer.createTransport({
    service: 'Gmail',
    auth: {
      user: process.env.EMAIL,
      pass: process.env.EMAIL_PASSWORD
    }
  });

  const mailOptions = {
    from: process.env.EMAIL,
    to: email,
    subject: subject,
    text: body
  };

  // The reason why I used promise here is because transporter.sendMail don't return any value
  return new Promise((resolve, reject) => {
    transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error('Error sending mail: ', error);
        reject({
          name: 'EmailError',
          message: errorMesage ?? error.message
        });
      }
      console.log('Email sent: ', info);
      resolve({
        message: successMessage ?? 'Email sent successfully'
      });
    });
  });
}

module.exports = sendMail;
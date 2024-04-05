const { Schema, model } = require("mongoose");

const userSchema = Schema({
  name: {
    type: String,
    required: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    trim: true,
    validate: {
      validator: (value) => {
        return /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(value);
      },
      message: 'Please enter a valid email address',
    },
  },
  passwordHash: {
    type: String,
    required: true,
  },
  street: String,
  apartment: String,
  city: String,
  postalCode: String,
  country: String,
  phone: {
    type: String,
    required: true,
    trim: true
  },
  isAdmin: { 
    type: Boolean,
    default: false
  },
  resetPasswordOtp: Number,
  resetPasswordOtpExpires: Date,
  resetPasswordOtpVerified: {
    type: Boolean,
    default: false,
  },
  cart: [{
    type: Schema.Types.ObjectId,
    ref: 'CardProduct'
  }],
  wishlist: [
    {
      productId: {
        type: Schema.Types.ObjectId,
        ref: 'Product',
        required: true
      },
      productName: {
        type: String,
        required: true,
      },
      productImage: {
        type: String,
        required: true,
      },
      productPrice: {
        type: Number,
        required: true,
      },
    },
  ],
});

userSchema.index({ email: 1 }, { unique: true });
userSchema.set('toObject', { virtuals: true });
userSchema.set('toJSON', { virtuals: true });

exports.User = model('User', userSchema);
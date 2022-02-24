"use strict";

module.exports.bye = async (event) => {
  return {
    statusCode: 200,
    body: "Bye from Testbed!"
  };
};

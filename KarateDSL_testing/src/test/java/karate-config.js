function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://api.realworld.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'trabuch21@gmail.com';
    config.userPassword = 'Pokemon1411';
  } else if (env == 'qa') {
    config.userEmail = 'trabuch21V2@gmail.com';
    config.userPassword = 'Pokemon1411-2';
  }

  const accessToken = karate.callSingle('classpath:helpers/createToken.feature', config).authToken;
  karate.configure('headers', {Authorization: 'Token '+ accessToken})
  return config;
}
const functions = require('firebase-functions/v1');
const crypto = require('crypto');
const axios = require('axios');
const querystring = require('querystring');

// Redirect користувача на Steam для аутентифікації
exports.steamAuth = functions.https.onRequest((req, res) => {
  const returnUrl = `https://us-central1-gameimprover-3babe.cloudfunctions.net/steamCallback`;
  const steamLoginUrl = `https://steamcommunity.com/openid/login?openid.ns=http://specs.openid.net/auth/2.0&openid.mode=checkid_setup&openid.return_to=${returnUrl}&openid.realm=${returnUrl}&openid.identity=http://specs.openid.net/auth/2.0/identifier_select&openid.claimed_id=http://specs.openid.net/auth/2.0/identifier_select`;
  
  res.redirect(steamLoginUrl);
});

// Обробка повернення від Steam після аутентифікації



exports.steamCallback = functions.https.onRequest(async (req, res) => {
  const query = req.query;

  if (query['openid.mode'] === 'id_res') {
    const params = {
      'openid.assoc_handle': query['openid.assoc_handle'],
      'openid.signed': query['openid.signed'],
      'openid.sig': query['openid.sig'],
      'openid.ns': 'http://specs.openid.net/auth/2.0',
      'openid.mode': 'check_authentication',
      'openid.op_endpoint': query['openid.op_endpoint'],
      'openid.claimed_id': query['openid.claimed_id'],
      'openid.identity': query['openid.identity'],
      'openid.return_to': query['openid.return_to'],
    };

    try {
      const steamVerificationResponse = await axios.post(
        'https://steamcommunity.com/openid/login',
        querystring.stringify(params),
        {
          headers: { 'Content-Type': 'application/x-www-form-urlencoded' }
        }
      );

      // Перевірка верифікації
      if (steamVerificationResponse.data.includes('is_valid:true')) {
        const steamID = extractSteamID(query['openid.claimed_id']);
        
        // Повертаємо Steam ID та логовані дані
        return res.json({
          message: 'Steam authentication successful',
          steamID: steamID,
          paramsSent: params,
          steamResponse: steamVerificationResponse.data
        });
      } else {
        // Повертаємо невдалу спробу аутентифікації разом із логами
        return res.status(401).json({
          message: 'Steam authentication failed',
          paramsSent: params,
          steamResponse: steamVerificationResponse.data
        });
      }
    } catch (error) {
      return res.status(500).json({
        message: 'Internal server error during Steam verification',
        error: error.message,
        paramsSent: params
      });
    }
  } else {
    return res.status(401).json({
      message: 'Steam authentication canceled or failed.',
      queryParams: query
    });
  }
});

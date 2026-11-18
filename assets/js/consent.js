/* FitCalcHub advertising consent integration.
 * Monetag is loaded only when the optional "advertising" category is accepted.
 */
(function () {
  'use strict';

  if (!window.CookieConsent) return;

  var monetagLoaded = false;
  var monetagUrl = 'https://nap5k.com/tag.min.js';
  var monetagZone = '11936432';

  function loadMonetagAfterConsent() {
    if (monetagLoaded || !window.CookieConsent.acceptedCategory('advertising')) return;

    monetagLoaded = true;
    var script = document.createElement('script');
    script.dataset.zone = monetagZone;
    script.src = monetagUrl;
    script.async = true;
    script.onerror = function () {
      monetagLoaded = false;
      script.remove();
    };
    document.head.appendChild(script);
  }

  window.CookieConsent.run({
    mode: 'opt-in',
    autoShow: true,
    hideFromBots: false,
    revision: 1,
    cookie: {
      name: 'fitcalchub_consent',
      path: '/',
      sameSite: 'Lax',
      secure: window.location.protocol === 'https:',
      expiresAfterDays: 180
    },
    categories: {
      necessary: {
        enabled: true,
        readOnly: true
      },
      advertising: {}
    },
    guiOptions: {
      consentModal: {
        layout: 'box wide',
        position: 'bottom center',
        equalWeightButtons: true,
        flipButtons: false
      },
      preferencesModal: {
        layout: 'box',
        position: 'right'
      }
    },
    onConsent: loadMonetagAfterConsent,
    onChange: loadMonetagAfterConsent,
    language: {
      default: 'en',
      translations: {
        en: {
          consentModal: {
            title: 'Your privacy choices',
            description: 'FitCalcHub uses optional advertising. Choose whether to allow the advertising category. Monetag is loaded only after you accept.',
            acceptAllBtn: 'Accept advertising',
            acceptNecessaryBtn: 'Reject optional advertising',
            showPreferencesBtn: 'Manage preferences',
            footer: '<a href="/privacy.html">Privacy Policy</a>'
          },
          preferencesModal: {
            title: 'Privacy preferences',
            acceptAllBtn: 'Accept advertising',
            acceptNecessaryBtn: 'Reject optional advertising',
            savePreferencesBtn: 'Save my choices',
            closeIconLabel: 'Close preferences',
            sections: [
              {
                title: 'Strictly necessary',
                description: 'The consent preference cookie is used to remember your choice.',
                linkedCategory: 'necessary'
              },
              {
                title: 'Optional advertising',
                description: 'If enabled, FitCalcHub loads the Monetag advertising script. Monetag and its advertising partners may use cookies or similar technologies and process technical information.',
                linkedCategory: 'advertising'
              },
              {
                title: 'More information',
                description: 'Read our <a href="/privacy.html">Privacy Policy</a> for details.'
              }
            ]
          }
        }
      }
    }
  });
})();

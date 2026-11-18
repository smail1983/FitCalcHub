/* FitCalcHub advertising consent integration.
 * Monetag is loaded only after the optional "advertising" category is accepted.
 * The consent banner and preferences remain available on every visitor-facing page.
 */
(function () {
  'use strict';

  if (!window.CookieConsent) return;

  var monetagLoaded = false;
  var monetagUrl = 'https://nap5k.com/tag.min.js';
  var monetagZone = '11936432';
  var monetagExcludedPages = [
    '/privacy.html',
    '/terms.html',
    '/medical-disclaimer.html',
    '/contact.html'
  ];

  var currentPath = window.location.pathname.replace(/\/+$/, '') || '/';
  var monetagAllowedOnThisPage = monetagExcludedPages.indexOf(currentPath) === -1;

  function hasAdvertisingConsent() {
    return window.CookieConsent.acceptedCategory('advertising');
  }

  function loadMonetagAfterConsent() {
    if (!monetagAllowedOnThisPage || monetagLoaded || !hasAdvertisingConsent()) {
      return;
    }

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

  function handleConsentChange() {
    if (monetagLoaded && !hasAdvertisingConsent()) {
      // A script already loaded on this document cannot be reliably "unexecuted".
      // Reloading starts a clean document; the saved opt-out prevents it loading again.
      window.location.reload();
      return;
    }

    loadMonetagAfterConsent();
  }

  window.CookieConsent.run({
    mode: 'opt-in',
    autoShow: true,
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
    onChange: handleConsentChange,
    language: {
      default: 'en',
      translations: {
        en: {
          consentModal: {
            title: 'Your privacy choices',
            description: 'Choose whether to allow optional advertising on FitCalcHub. Monetag loads only after you accept and is disabled on our Privacy, Terms, Medical Disclaimer and Contact pages.',
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
                description: 'If enabled, FitCalcHub loads the Monetag advertising script on eligible pages. It is not loaded on the Privacy, Terms, Medical Disclaimer or Contact pages. Monetag and its advertising partners may use cookies or similar technologies and process technical information.',
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

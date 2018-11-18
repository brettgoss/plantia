// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require serviceworker-companion
//= require_tree .
//= stub "serviceworker.js"

// Check for service worker support
if ('serviceWorker' in navigator) {
  console.log('Service Worker is supported');
  // Register the serviceworker (and serviceworker.js)
  navigator.serviceWorker.register('/serviceworker.js')
    .then(function (registration) {
      console.log('Successfully registered!', ':)', registration);
      // Ask the user for permissions to send notifications
      // TODO: Move this out to after a user clicks a button
      // navigator.serviceWorker.ready.then((serviceWorkerRegistration) => {
      //   serviceWorkerRegistration.pushManager
      //     .subscribe({
      //       userVisibleOnly: true,
      //       applicationServerKey: window.vapidPublicKey
      //     });
      // })
    }).catch(function (error) {
      console.log('Registration failed', ':(', error);
    });
}

// This is a duplicate of the above?
if (navigator.serviceWorker) {
  navigator.serviceWorker.register('/serviceworker.js')
    .then(function (reg) {
      console.log('Service worker change, registered the service worker');
    });
} else { // Otherwise, no push notifications :(
  console.error('Service workers are not supported in this browser');
}
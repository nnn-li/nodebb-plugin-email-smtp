'use strict';

// @auth zan

var winston = module.parent.require('winston'),
    Meta = module.parent.require('./meta'),

    nodemailer = require('nodemailer'),
    Emailer = {};


var settings = {};

Emailer.init = function(data, callback) {
    function renderAdminPage(req, res) {
        res.render('admin/emailers/local', {});
    }

    data.router.get('/admin/emailers/local', data.middleware.admin.buildHeader, renderAdminPage);
    data.router.get('/api/admin/emailers/local', renderAdminPage);

    Meta.settings.get('emailer-local', function(err, _settings) {
        if (err) {
            return winston.error(err);
        }
        settings = _settings;
    });

    callback();
};

Emailer.send = function(data, callback) {

    var username = settings['emailer:local:username'];
    var pass = settings['emailer:local:password'];
    var transportOptions = {
        host: settings['emailer:local:host'],
        port: settings['emailer:local:port'],
        secureConnection: settings['emailer:local:secure'] === 'on'
    };
    if( username || pass ) {
        transportOptions.auth = {
            user: username,
            pass: pass
        };
    }
    var transport = nodemailer.createTransport(transportOptions);

    transport.sendMail({
        from: {
            name: data.from_name,
            address: data.from
        }, // sender address ,
        to: data.to,
        html: data.html,
        text: data.plaintext,
        subject: data.subject
    },function(err) {
        if ( !err ) {
            winston.info('[emailer.smtp] Sent `' + data.template + '` email to uid ' + data.uid);
        } else {
            winston.warn('[emailer.smtp] Unable to send `' + data.template + '` email to uid ' + data.uid + '!!');
          }
        callback(err, data);
    });
};

Emailer.admin = {
    menu: function(custom_header, callback) {
        custom_header.plugins.push({
            "route": '/emailers/local',
            "icon": 'fa-envelope-o',
            "name": '邮件服务 (SMTP)'
        });

        callback(null, custom_header);
    }
};

module.exports = Emailer;

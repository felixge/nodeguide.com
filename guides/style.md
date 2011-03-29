# Felix's Node.js Style Guide

There is no official document that governs the style of node.js applications. This guide is my oppionated attempt to bring you a good set of instructions that will allow you to create beautiful and consistent software.

This guide assumes that you are only targetting node.js. If your code also needs to run in the browser or other environments, please ignore some of it.

## Tabs vs Spaces

Let's start with the religious problems first. Our benevolant dictator^ has choosen 2 space indention for the node core, so you would do well to follow his orders.

## Semicolons

There are rebilious forces^ that try to steal your semicolons from you. But make no mistake, our traditional culture is still well and alive. So follow our great dictators C-loving style and use those semicolons!

## Editors

You can use any editor. However, having support for JS syntax highlighting and executing the currently open file with node.js will come in very handy. While vim^ may not help you to impress the ladies, it will please the BDFL^ and your grandpa will also approve.

I'm typing this document in Notes on my iPad, but that's beacause I'm on a beach in Thailand, your work environment may impact your choice of editors as well.

## Trailing whitespace

Just like you brush your teeth after every meal, you clean up any trailing whitespace in your JavaScript files before committing. Otherwise the rotten smell of careless neglect will drive away any contributors or co-workers after a while.

## Line length

Limit your lines to 80 characters. Yes, screens have gotten much bigger over the last few years, but your brain hasn't. Use the additional room for split screen, your editor supports that, right?

## Quotes

Use single quotes, unless you are writing JSON.

Right:

var foo = 'bar';

Wrong:

var foo = "bar";

## Braces

Your opening braces go on the same line as the statement.

Right:

if (true) {
  console.log('winning);
}

Wrong:

if (true)
{
  console.log('loosing');
}

Also notice the usage of spaces before and after the condition statement.

## Variable declarations

Declare one variable per var statement, it makes it easier to re-order the lines. Ignore Crockford^ on this, and put those declarations wherever they make sense.

Right:

var keys = ['foo', 'bar'];
var values = [23, 42];

var object = {};
while (items.length) {
  var key = keys.pop();
  object[key] = values.pop();
}

Wrong:

var keys = ['foo', 'bar'],
      values = [23, 42],
      object = {},
      key;

while (items.length) {
  key = keys.pop();
  object[key] = values.pop();
}

## Variable and property names

Variables and properties should use camelBack^ capitalization. They should also be descriptive. Single character variables and uncommon abbriviations should generally be avoided.

Right:

var adminUser = db.query('SELECT * FROM users ...');

Wrong:

var admin_user = d.query('SELECT * FROM users ...');

## Class names

Class names should be captialized using CamelCase^.

Right:

function BankAccount() {
}

Wrong:

function bank_Account() {
}

## Constants

Constants should be declared as regular variables or class properties, using all uppercase letters. ^explain why const is bad

Right:

var SECOND = 1 * 1000;

function File() {
}
File.FULL_PERMISSIONS = 0777;

Wrong:

const SECOND = 1 * 1000;

function File() {
}
File.fullPermissions = 0777; 

## Object / Array creation

Use trailing commas and put *short* declarations on a single line, only quote keys when your interpreter complains:

Right:

var a = ['hello', 'world'];
var b = {
  good: 'code',
  'is generally': 'pretty',
};

Wrong:

var a = [
  'hello', 'world'
];
var b = {"'good": 'code'
             , 'is generally': 'pretty'};

## Equality operator

Programming is not about remembering stupid rules. Use the tripple equality operator as it will work just as expected. ^check example

Right:

var a = 0;
if (a === '') {
  console.log('winning');
}

Wrong:

var a = 0;
if (a == '') {
  console.log('loosing');
}

## Extending protoypes

Do not extend the prototypes of any objects after it has been initially defined. There is a special place in hell waiting for you if you don't obey this rule.

Right:

var a = [];
if (!a.length) {
  console.log('winning');
}

Wrong:

Array.prototype.empty = function() {
  return !this.length;
}

var a = [];
if (a.empty()) {
  console.log('loosing');
}

## Conditions

Any non-trivial conditions should be assigned to a descriptive variable:

Right:

var isAuthorized = (user.isAdmin() || user.isModerator());
if (isAuthorized) {
  console.log('winning');
}

Wrong:

if (user.isAdmin() || user.isModerator()) {
  console.log('loosing');
}

## Function length

Keep your functions short. A good function fits on a slide that the people in the last row of a big room can comfortably read. So don't count on them having perfect vision and limit yourself to ~10 lines of code per function.

## Return statements

To avoid deep nesting of if-statements, always return a functions value as early asossible.

Right:

function isPercentage(val) {
  if (val < 0) {
    return false;
  }

  if (val > 100) {
    return false;
  }

   return true;
}

Wrong:

function isPercentage(val) {
  if (val < 0) {
    if (val > 100) {
      return false;
    } else {
      return true;
    }
  } else {
    return false;
  }
}

Or for this particular example it may also be fine to shorten things even further:

function isPercentage(val) {
  var isInRange = (val >= 0 && val <= 100);
  return isInRange;
}

## Named closures

Feel free to give your closures a name. It shows at you care about them, and will produce better stack traces:

Right:

req.on('end', function onEnd() {
  console.log('winning');
});

Wrong:

req.on('end', function() {
  console.log('loosing');
});

## Nested Closures

Use closures, but don't nest them. Otherwise your code will become a mess.

Right:

setTimeout(function() {
  client.connect(afterConnect);
}, 1000);

function afterConnect() {
  console.log('winning');
}

Wrong:

setTimeout(function() {
  client.connect(function() {
    console.log('loosing');
  });
}, 1000);

## Callbacks

Since node is all about non-blocking I/O, functions generally return their results using callbacks. The convention used by the node core to reserve the first parameter of any callback for an optional error object.

Right:

var fs = require('fs');

function loadConfig(cb) {
  fs.readFile('config.json', 'utf-8', function(err, data) {
    if (err) {
      cb(err);
      return;
    }

    try {
      var config = JSON.parse(data);
      cb(null, config);
    } catch (jsonParseError) {
      cb(jsonParseError);
    }
  });
}

Wrong:

var fs = require('fs');

function loadConfig(cb) {
  fs.readFile('config.json', 'utf-8', function(err, data) {
    if (err) {
      cb(err);
      return;
    }

    try {
      var config = JSON.parse(data);
      cb(config);
    } catch (jsonParseError) {
      cb(jsonParseError);
    }
  });
}

## Object.freeze, Object.create, with and eval ^maybe others

Crazy shit that you will propably never need. Stay away from it.

## Getters and setters

Do not use setters, they cause more problems for people who try to use your software than they can solve.

Feel free to use getters for side-effect free functions^, like providing a length property for a collection class.

## EventEmitters

Node.js ships with a simple EventEmitter class that can be included from the 'events' module:

var EventEmitter = require('events').EventEmitter;

When creating complex classes, it is common to inherit from this EventEmitter class to emit events. This is basically a simple implementation of the Observable^ pattern.

However, I strongly recommend that you never listen to the events of your own class from within it. It's not natural for an object to observe itself. It often leads to undesirable exposure of internal implementationd details, and makes your code more difficult to follow along.

## Inheritence / Object oriented programming

Inheritence and object oriented programming are a whole subject by themselves. If you're interested in following this popular programming model, please read my Object oriented programming guide^.


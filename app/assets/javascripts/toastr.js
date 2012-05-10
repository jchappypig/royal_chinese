// By: Hans Fj�llemark and John Papa
// https://github.com/CodeSeven/toastr
// 
// Modified to support css styling instead of inline styling
// Based on original version at https://github.com/Srirangan/notifer.js/

(function (window, $) {
    window.toastr = (function () {
        var
            defaults = {
                tapToDismiss: true,
                toastClass: 'toast',
                containerId: 'toast-container',
                debug: false,
                fadeIn: 300,
                fadeOut: 300,
                iconClasses: {
                    error: 'toast-error',
                    info: 'toast-info',
                    success: 'toast-success',
                    warning: 'toast-warning'
                },
                iconClass: 'toast-info',
                positionClass: 'toast-top-right',
                timeOut: 0, // Set timeOut to 0 to make it sticky
                titleClass: 'toast-title',
                messageClass: 'toast-message',
                dependencyElement: 'body'
            },


            error = function (message, title) {
                return notify({
                    iconClass: getOptions().iconClasses.error,
                    message: message,
                    title: title
                })
            },

            success = function (message, title) {
                return notify({
                    iconClass: getOptions().iconClasses.success,
                    message: message,
                    title: title
                })
            },

            warning = function (message, title) {
                return notify({
                    iconClass: getOptions().iconClasses.warning,
                    message: message,
                    title: title
                })
            },

            info = function (message, title) {
                return notify({
                    iconClass: getOptions().iconClasses.info,
                    message: message,
                    title: title
                })
            },

            notify = function (map) {
                var
                    options = getOptions(),
                    iconClass = map.iconClass || options.iconClass,
                    $container = getContainer(options),
                    $toastElement = $('<div/>'),
                    $titleElement = $('<div/>'),
                    $messageElement = $('<div/>'),
                    response = { options: options, map: map }

                if (map.iconClass) {
                    $toastElement.addClass(options.toastClass).addClass(iconClass)
                }

                if (map.title) {
                    $titleElement.append(map.title).addClass(options.titleClass)
                    $toastElement.append($titleElement)
                }

                if (map.message) {
                    $messageElement.append(map.message).addClass(options.messageClass)
                    $toastElement.append($messageElement)
                }

                var fadeAway = function () {
                    var fade = function () {
                        return $toastElement.fadeOut(options.fadeOut)
                    }

                    $.when(fade()).done(function () {
                        $toastElement.remove()

                        if ($container.children().length === 0)
                            $container.remove()
                    })
                }

                $toastElement.hide()
                $container.prepend($toastElement)
                $toastElement.fadeIn(options.fadeIn)

                if (options.timeOut > 0) {
                    setTimeout(fadeAway, options.timeOut)
                }

                if (options.tapToDismiss) {
                    $toastElement.click(fadeAway)
                }

                if (options.debug) {
                    console.log(response)
                }
                return $toastElement
            },

            getOptions = function () {
                return $.extend({}, defaults, toastr.options)
            },

            getContainer = function (options) {
                var $container = $('#' + options.containerId)

                if ($container.length)
                    return $container

                $container = $('<div/>')
                    .attr('id', options.containerId)
                    .addClass(options.positionClass)

                $container.appendTo($(options.dependencyElement))

                return $container
            }

        return {
            error: error,
            info: info,
            options: {},
            success: success,
            warning: warning
        }
    })()
} (window, jQuery))
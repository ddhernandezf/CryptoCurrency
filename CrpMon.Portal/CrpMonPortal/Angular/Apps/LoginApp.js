var app = angular.module("LoginApp", ["kendo.directives"]);

app.directive("compareTo", function () {
    return {
        require: "ngModel",
        scope: {
            otherModelValue: "=compareTo"
        },
        link: function (scope, element, attributes, ngModel) {

            ngModel.$validators.compareTo = function (modelValue) {
                return modelValue == scope.otherModelValue.$modelValue;
            };

            scope.$watch("otherModelValue", function () {
                ngModel.$validate();
            });
        }
    };
});

app.directive("excludeTo", function () {
    return {
        require: "ngModel",
        scope: {
            otherModelValue: "=excludeTo"
        },
        link: function (scope, element, attributes, ngModel) {

            ngModel.$validators.excludeTo = function (modelValue) {
                if (modelValue == null && scope.otherModelValue.$modelValue == null) {
                    return true;
                }
                else {
                    return modelValue != scope.otherModelValue.$modelValue;
                }
            };

            scope.$watch("otherModelValue", function () {
                ngModel.$validate();
            });
        }
    };
});
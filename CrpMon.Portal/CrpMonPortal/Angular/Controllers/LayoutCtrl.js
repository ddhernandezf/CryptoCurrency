app.controller('LayoutCtrl', function ($rootScope, $scope, $http) {
    $rootScope.ModeloVista = null;
    $rootScope.ModeloLenguaje = null;
    $scope.ModeloLogin = { vNombreUsuario: null, vContrasena: null };
    $scope.AutenticarError = null;

    llamarData($http).Idiomas().then(function (response) {
        $rootScope.ModeloLenguaje = response.data;

        kdlIdioma($http, $scope, $rootScope.ModeloLenguaje.Idiomas, $rootScope.ModeloLenguaje.IdiomaSeleccionado);
    }, function (error) {
        console.log(error);
    });

    llamarData($http).Menu().then(function (response) {
        $rootScope.ModeloMenu = response.data;

        $scope.kwnMenuOpt = {
            width: "200px",
            title: "MENU",
            visible: false,
            modal: true,
            actions: ["close"]
        };

        $scope.kmnOrientacion = "vertical";
        $scope.kmnOptions = {
            closeOnClick: true,
            scrollable: true
        };
        $scope.menuData = $rootScope.ModeloMenu;
        $scope.kmnSelect = function (e) {
            if ($($(e.item).children()[0]).attr('href')) {
                $('.blocker').show();

                e.preventDefault();
                var txtItem = $(e.item).text(), urlItem = $($(e.item).children()[0]).attr('href');

                var tbsGeneral = $("#tbsGeneral").data("kendoTabStrip");
                var tbsGeneralResp = $("#tbsGeneralResp").data("kendoTabStrip");

                if ($('ul.k-tabstrip-items li.k-item:contains(' + txtItem + ')').length == 0) {
                    tbsGeneral.append({
                        id: txtItem,
                        text: txtItem,
                        contentUrl: urlGlobal + "Generales/IframeView?url=" + urlItem
                    });

                    tbsGeneralResp.append({
                        id: txtItem,
                        text: txtItem,
                        contentUrl: urlGlobal + "Generales/IframeView?url=" + urlItem
                    });

                    tbsGeneral.select("li:contains(" + txtItem + ")");

                    tbsGeneralResp.select("li:contains(" + txtItem + ")");
                }
                else {
                    tbsGeneral.select("li:contains(" + txtItem + ")");

                    tbsGeneralResp.select("li:contains(" + txtItem + ")");

                    $('.blocker').hide();
                }

                $scope.menuGeneral.close();
                $scope.kwnMenu.close();
            }
        };

        var tbsGeneral = $("#tbsGeneral").kendoTabStrip({
            animation: {
                open: {
                    effects: "fadeIn"
                }
            }
        }).data("kendoTabStrip");

        var tbsGeneralResp = $("#tbsGeneralResp").kendoTabStrip({
            animation: {
                open: {
                    effects: "fadeIn"
                }
            }
        }).data("kendoTabStrip");

        var desc = $rootScope.ModeloMenu[0].Descripcion;
        var url = $rootScope.ModeloMenu[0].url;

        tbsGeneral.append({
            id: desc,
            text: desc,
            contentUrl: urlGlobal + "Generales/IframeView?url=" + url
        });
        tbsGeneral.select("li:contains(" + desc + ")");

        tbsGeneralResp.append({
            id: desc,
            text: desc,
            contentUrl: urlGlobal + "Generales/IframeView?url=" + url
        });
        tbsGeneralResp.select("li:contains(" + desc + ")");

        $('.blocker').show();
    }, function (error) {
        console.log(error);
    });

    $scope.LlamarMenu = function () {
        $scope.kwnMenu.open();
        $scope.kwnMenu.center();
    };
});

function llamarData($http) {
    return {
        Menu: consultarMenu,
        Idiomas: consultarIdioma
    }

    function consultarMenu() {
        return $http.post(urlGlobal + 'Seguridad/Menu');
    }

    function consultarIdioma() {
        return $http.get(urlGlobal + 'Generales/Idiomas');
    }
}
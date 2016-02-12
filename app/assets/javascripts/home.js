var app = angular.module("myApp",[]);

var messages = [{ "messageId": "26bd9a57-7c50-48bc-85f4-267693aa14c2", "externalId": "SMeb952462b0d5407a8e0015ed34145717", "companyId": 13, "direction": 0, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "another test", "status": 6, "errorCode": null, "createdOn": "2014-09-02T21:14:04.447", "createdBy": null, "updatedOn": "2014-09-02T21:16:15.843", "sentOn": "2014-09-02T21:16:15.843" }, { "messageId": "d1b71bd9-c83d-4876-a27d-acf798604f60", "externalId": "SM652a9a21bf7f49c29dbb3b29e19f9f7f", "companyId": 13, "direction": 0, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Hello Again4", "status": 6, "errorCode": null, "createdOn": "2014-08-26T22:26:05.997", "createdBy": null, "updatedOn": "2014-08-27T18:15:59.723", "sentOn": "2014-08-27T18:15:59.723" }, { "messageId": "75a9322a-e695-41ae-af3c-766364c6c87b", "externalId": "SM3b30488ea29e11ce0d0b6ab57fc86957", "companyId": 13, "direction": 1, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Test reply", "status": 5, "errorCode": null, "createdOn": "2014-08-26T22:23:32.08", "createdBy": null, "updatedOn": "2014-08-26T22:23:32.08", "sentOn": "2014-08-26T22:23:32.08" }, { "messageId": "625ef260-7371-48a2-8cda-f1e9eb3edff9", "externalId": "SM9a505ebde1814c5a87946ab9e7a7e207", "companyId": 13, "direction": 0, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Hello Again3", "status": 6, "errorCode": null, "createdOn": "2014-08-26T22:03:23.52", "createdBy": null, "updatedOn": "2014-08-27T18:15:41.037", "sentOn": "2014-08-27T18:15:41.037" }, { "messageId": "3fd2d24b-232a-47f7-bce6-e3ca437a5005", "externalId": "SMa7dd6b2b880b4b82a499d102dcaf0da6", "companyId": 13, "direction": 0, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Hello Again", "status": 6, "errorCode": null, "createdOn": "2014-08-26T19:23:17.633", "createdBy": null, "updatedOn": "2014-08-27T18:15:22.093", "sentOn": "2014-08-27T18:15:22.093" }, { "messageId": "a4024f5f-7869-439c-b234-17655d072d8e", "externalId": "SMbe554efc0ebf43b0a989eca9d8b12784", "companyId": 13, "direction": 0, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Hello Back", "status": 6, "errorCode": null, "createdOn": "2014-08-26T19:01:07.977", "createdBy": null, "updatedOn": "2014-08-27T18:14:24.367", "sentOn": "2014-08-27T18:14:24.367" }, { "messageId": "ad63a28e-943e-48fe-ae00-e51de9f3d88f", "externalId": "SMa79c1205a78d064d1660f6b05f2699c4", "companyId": 13, "direction": 1, "customerNumber": "+17273314889", "dealershipNumber": "+17272402455", "body": "Test", "status": 0, "errorCode": null, "createdOn": "2014-08-26T18:51:04", "createdBy": null, "updatedOn": "2014-08-26T18:51:04", "sentOn": "2014-08-26T18:51:04" }];


app.controller('inboxCtrl', ['$scope', '$filter', function ($scope, $filter) {


        $scope.date = new Date;
        $scope.sortingOrder = 'id';
        $scope.pageSizes = [10,20,50,100];
        $scope.reverse = false;
        $scope.filteredItems = [];
        $scope.groupedItems = [];
        $scope.itemsPerPage = 10;
        $scope.pagedItems = [];
        $scope.currentPage = 0;

        /* inbox functions -------------------------------------- */

        // get data and init the filtered items
        $scope.init = function () {

            $scope.items = messages;
            $scope.search();

        }

        var searchMatch = function (haystack, needle) {
            if (!needle) {
                return true;
            }
            return haystack.toLowerCase().indexOf(needle.toLowerCase()) !== -1;
        };

        // filter the items
        $scope.search = function () {
            $scope.filteredItems = $filter('filter')($scope.items, function (item) {
                for(var attr in item) {
                    if (searchMatch(item[attr], $scope.query))
                        return true;
                }
                return false;
            });
            $scope.currentPage = 0;
            // now group by pages
            $scope.groupToPages();
        };

        // calculate page in place
        $scope.groupToPages = function () {
            $scope.selected = null;
            $scope.pagedItems = [];

            for (var i = 0; i < $scope.filteredItems.length; i++) {
                if (i % $scope.itemsPerPage === 0) {
                    $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)] = [ $scope.filteredItems[i] ];
                } else {
                    $scope.pagedItems[Math.floor(i / $scope.itemsPerPage)].push($scope.filteredItems[i]);
                }
            }
        };

        $scope.range = function (start, end) {
            var ret = [];
            if (!end) {
                end = start;
                start = 0;
            }
            for (var i = start; i < end; i++) {
                ret.push(i);
            }
            return ret;
        };

        $scope.prevPage = function () {
            if ($scope.currentPage > 0) {
                $scope.currentPage--;
            }
            return false;
        };

        $scope.nextPage = function () {
            if ($scope.currentPage < $scope.pagedItems.length - 1) {
                $scope.currentPage++;
            }
            return false;
        };

        $scope.setPage = function () {
            $scope.currentPage = this.n;
        };

        $scope.deleteItem = function (idx) {
            var itemToDelete = $scope.pagedItems[$scope.currentPage][idx];
            var idxInItems = $scope.items.indexOf(itemToDelete);
            $scope.items.splice(idxInItems,1);
            $scope.search();

            return false;
        };

        $scope.isMessageSelected = function () {
            if (typeof $scope.selected!=="undefined" && $scope.selected!==null) {
                return true;
            }
            else {
                return false;
            }
        };

        $scope.readMessage = function (idx) {
            $scope.items[idx].read = true;
            $scope.selected = $scope.items[idx];
        };

        $scope.readAll = function () {
            for (var i in $scope.items) {
                $scope.items[i].read = true;
            }
        };

        $scope.closeMessage = function () {
            $scope.selected = null;
        };

        $scope.renderMessageBody = function(html)
        {
            return html;
        };

        /* end inbox functions ---------------------------------- */


        // initialize
        $scope.init();

    }])// end inboxCtrl
    .controller('messageCtrl', ['$scope', function ($scope) {

        $scope.message = function(idx) {
            return messages(idx);
        };

    }]);// end messageCtrl





//$(document).ready(function(){});
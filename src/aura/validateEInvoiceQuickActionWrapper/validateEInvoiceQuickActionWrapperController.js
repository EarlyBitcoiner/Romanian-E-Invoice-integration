/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 4.7.2024 г.
 */
({
	handleClose: function (cmp, event, helper) {
		$A.get("e.force:closeQuickAction").fire();
	}
});
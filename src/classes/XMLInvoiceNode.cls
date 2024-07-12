/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 27.6.2024 г.
 * 
 * @description Class designed to be inherited by all sub-classes inside the CBC and CAC Apex classes. Used in polymorphic iteration.
 */
public interface XMLInvoiceNode {

	/**
	 * @param outerNode The outer XML node which needs to be populated with another XML node
	 */
	void populateXmlNode( Dom.XmlNode outerNode );

}
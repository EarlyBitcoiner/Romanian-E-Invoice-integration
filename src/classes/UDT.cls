/**
 * Created By: petar.danadzhiev@next-consult.com - Junior Developer.
 * Created Date: 25.6.2024 г..
 *
 * @description Apex Class representing the elements in "UnqualifiedDataTypes" also known as U.D.T from "urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2"
 */
public class UDT {
	private static final String UDT_NAMESPACE = 'urn:oasis:names:specification:ubl:schema:xsd:UnqualifiedDataTypes-2';

	public class AmountType {

		public Decimal value;
		public String currencyID;

		public AmountType(Decimal amount, String currencyID){
			this.value = amount;
			this.currencyID = currencyID;
		}
	}

	public class BinaryObjectType {

		public String value;
		public String format;
		public String mimeCode;
		public String encodingCode;
		public String characterSetCode;
		public String uri;
		public String filename;

		public BinaryObjectType(String value){
			this.value = value;
		}
	}

	public class CodeType {
		public String value;
		public String listID;
		public String listAgencyID;
		public String listAgencyName;
		public String listName;
		public String listVersionID;
		public String name;
		public String languageID;
		public String listURI;
		public String listSchemeURI;

		public CodeType(String value){
			this.value = value;
		}
	}

	public class DateTimeType {

		public String value;
		public String format;

		public DateTimeType(String value, String format){
			this.value = value;
			this.format = format;
		}
	}

	public class DateType {
		public Date value;

		public DateType(Date value){
			this.value = value;
		}
	}

	public class GraphicType {

		public String value;
		public String format;
		public String mimeCode; // required
		public String encodingCode;
		public String characterSetCode;
		public String uri;
		public String filename;

		public GraphicType(String value){
			this.value = value;
		}
	}

	public class IdentifierType {
		public String value;
		public String schemeID;
		public String schemeName;
		public String schemeAgencyID;
		public String schemeAgencyName;
		public String schemeVersionID;
		public String schemeDataURI;
		public String schemeURI;

		public IdentifierType(){}

		public IdentifierType(String value){
			this.value = value;
		}

		public IdentifierType(String value, String schemeID){
			this.value = value;
			this.schemeID = schemeID;
		}
	}

	public class IndicatorType {
		public Boolean value;

		public IndicatorType(Boolean value){
			this.value = value;
		}
	}

	public class MeasureType {

		public Decimal value;
		public String unitCode; // required
		public String unitCodeListVersionID;

		public MeasureType(Decimal value){
			this.value = value;
		}
	}

	public class NameType {
		public String value;
		public String languageID;
		public String languageLocaleID;

		public NameType(String value){
			this.value = value;
		}
	}

	public class NumericType {
		public Decimal value;
		public String format;

		public NumericType(Decimal value){
			this.value = value;
		}
	}

	public class PercentType {
		public Decimal value;
		public String format;

		public PercentType(Decimal value){
			this.value = value;
		}
	}

	public class PictureType {

		public String value;
		public String format;
		public String mimeCode; // required
		public String encodingCode;
		public String characterSetCode;
		public String uri;
		public String filename;

		public PictureType(String value){
			this.value = value;
		}
	}

	public class QuantityType {

		public Decimal value;
		public String unitCode;
		public String unitCodeListID;
		public String unitCodeListAgencyID;
		public String unitCodeListAgencyName;

		public QuantityType(Decimal value){
			this.value = value;
		}

		public QuantityType( Decimal value, String unitCode ) {
			this.value = value;
			this.unitCode = unitCode;
		}
	}

	public class RateType {
		public Decimal value;
		public String format;

		public RateType(Decimal value){
			this.value = value;
		}
	}

	public class SoundType {

		public String value;
		public String format;
		public String mimeCode; // required
		public String encodingCode;
		public String characterSetCode;
		public String uri;
		public String filename;

		public SoundType(String value){
			this.value = value;
		}
	}

	public class TextType {

		public String value;
		public String languageID;
		public String languageLocaleID;

		public TextType(String value){
			this.value = value;
		}
	}

	public class TimeType {

		public Time value;

		public TimeType(Time value){
			this.value = value;
		}
	}

	public class ValueType {
		public Decimal value;
		public String format;

		public ValueType(Decimal value){
			this.value = value;
		}
	}

	public class VideoType {

		public String value;
		public String format;
		public String mimeCode; // required
		public String encodingCode;
		public String characterSetCode;
		public String uri;
		public String filename;

		public VideoType(String value){
			this.value = value;
		}
	}
}
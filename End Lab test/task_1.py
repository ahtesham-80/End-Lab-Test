import re

def extract_invoice_details(text):
    """
    Extract invoice number, tax amount, and total amount from a paragraph.

    Parameters:
        text (str): Raw invoice text.

    Returns:
        dict: {
            "invoice_number": str or None,
            "tax_amount": float or None,
            "total_amount": float or None
        }
    }
    """

    # Patterns for invoice number
    invoice_patterns = [
        r"Invoice\s*No\.?\s*[:\-]?\s*(\w+)",
        r"Invoice\s*Number\s*[:\-]?\s*(\w+)",
        r"Inv\s*#\s*[:\-]?\s*(\w+)"
    ]

    # Patterns for tax (GST, VAT, TAX)
    tax_patterns = [
        r"(?:GST|Tax|VAT)\s*[:\-]?\s*₹?\$?\€?\s*([\d,]+\.\d+|\d+)"
    ]

    # Patterns for total amount
    total_patterns = [
        r"(?:Total|Grand Total|Amount Payable|Total Amount)\s*[:\-]?\s*₹?\$?\€?\s*([\d,]+\.\d+|\d+)"
    ]

    def extract_value(patterns, text):
        """Try each regex pattern and return cleaned extracted value."""
        for p in patterns:
            match = re.search(p, text, re.IGNORECASE)
            if match:
                value = match.group(1)
                value = value.replace(",", "")  # remove commas in numbers
                try:
                    return float(value)
                except:
                    return value
        return None

    return {
        "invoice_number": extract_value(invoice_patterns, text),
        "tax_amount": extract_value(tax_patterns, text),
        "total_amount": extract_value(total_patterns, text)
    }


# ------------------------------
#           TEST CASES
# ------------------------------

if __name__ == "__main__":
    sample1 = """
    Invoice No: INV0921
    GST: ₹450.75
    Grand Total: ₹5,200.00
    """
    print(extract_invoice_details(sample1))

    sample2 = """
    Inv # 88771
    VAT: 99
    Amount Payable: 1200
    """
    print(extract_invoice_details(sample2))

    sample3 = """
    This invoice shows a total amount of $345.99 including a tax of $29.50.
    Invoice Number: A5544
    """
    print(extract_invoice_details(sample3))

    sample4 = """
    No invoice number here. Tax is 20. Total is 100.
    """
    print(extract_invoice_details(sample4))

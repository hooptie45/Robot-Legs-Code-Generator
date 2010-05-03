=begin
# $Id: manual.rd.src,v 1.1 2003/01/22 16:41:45 katsu Exp $

= xmlscan version 0.2 ��ե���󥹥ޥ˥奢��

== ����

xmlscan �� Ruby �����ǽ񤫤줿 non-validating XML parser �Ǥ���

���Τ褦����Ĺ������ޤ���

: 100% pure Ruby
    ��ĥ�饤�֥������ɬ�פȤ��ʤ��Τǡ�1.6 �ʾ�� Ruby ���󥿥ץ꥿����
    ����д�����ư��ޤ���(ɸ��ź�դγ�ĥ�饤�֥���ɬ�פȤ��ޤ���)

: ���ʤؤ�Ŭ����
    xmlscan �ϡ�XML 1.0 Specification �ǽҤ٤��Ƥ��롢�������򸡾ڤ��ʤ�
    �ץ����˵��������Ƥξ������������Ȥ���ɸ�˳�ȯ���ʤ����
    ���ޤ���

: ��®
    xmlscan �β��Ϥ�®���ϡ������餯����¸���� Ruby �ǽ񤫤줿
    XML/HTML parser ����Ǻ�®�Ǥ���

: �͡���CES���б�
    xmlscan �Ͼ��ʤ��Ȥ� iso-8859-*, EUC-*, Shift_JIS, UTF-8 �ǽ񤫤줿
    XMLʸ��򤽤Τޤ޲��ϤǤ��ޤ��������� UTF-16 �ϰ����ޤ���

: ���Ϥ������
    xmlscan �����ϡ�����XMLʸ�����Ϥ��뤳�Ȥ����Ǥ���XMLʸ���
    ���ؤ˼�갷������ι��٥�ʵ�ǽ���󶡤��ޤ���xmlscan ��
    ���Τ褦�ʵ�ǽ���󶡤���饤�֥��Υ�����ʬ�Ȥ��ƻȤ��뤳�Ȥ�
    ���ꤷ�Ƥ��ޤ���

: HTML
    ���ޥ��� HTML ��ʸ���Ϥ��� htmlscan ���դ��Ƥ��ޤ���


== ʸ�����󥳡��ǥ��󥰤ˤĤ���

�ǥե���ȤǤϡ�xmlscan ���ɤ� CES (Character Encoding Scheme) ��
XMLʸ�����Ϥ��뤫�ϥ����Х��ѿ� $KCODE ���ͤˤ�äƷ�ޤ�ޤ���
EUC-*, Shift_JIS, UTF-8 �ǽ񤫤줿XMLʸ�����Ϥ���ˤ� $KCODE ��
((<XMLScan::XMLScanner#kcode=>)) ��Ŭ�ڤ��ͤ����ꤹ��ɬ�פ�����ޤ���

UTF-16 ��ľ�ܥ��ݡ��Ȥ��Ƥ��ޤ��󡣲������˰�ö UTF-8 ���Ѵ�����
ɬ�פ�����ޤ���


== XML̾�����֤ˤĤ���

XML̾�����֤� xmlscan/namespace.rb �Ǽ�������Ƥ��ޤ��������󥿡��ե�������
�礭���ѹ�����ͽ�꤬���뤿�� undocumented �Ȥ��ޤ���



== ���饹��ե����


=== XMLScan::Error

xmlscan �˴ؤ������Ƥ��㳰�Υ����ѡ����饹��

�������㳰�ϡ�XMLScan::Visitor �Υ��󥹥��󥹤���XMLScan::XMLScanner ��
XMLScan::XMLParser ���饨�顼���������ä��Ȥ��ˡ��ǥե���Ȥ�ȯ��������
��ΤǤ����ƥѡ�����ľ�ܤ������㳰���ꤲ�뤳�ȤϤ���ޤ���

#�����㳰�� xmlscan/scanner.rb ���������Ƥ��ޤ���

: XMLScan::ParseError

    ������§�˥ޥå����ʤ����������ȿ�ʳ��Υ��顼��

: XMLScan::NotWellFormedError

    ����������˰�ȿ���Ƥ��롣

: XMLScan::NotValidError

    ����������˰�ȿ���Ƥ��롣


=== XMLScan::Visitor

XMLʸ��β��Ϸ�̤������뤿��� Mix-in �Ǥ���

xmlscan �˴ޤޤ��� parser �ϡ�ʸ�����Ƭ���鹽ʸ���Ϥ�Ԥ�����������
��ʸ���Ǥ򸫤Ĥ��뤿�Ӥˡ��ѡ�����Ϳ����줿 XMLScan::Visitor ��
���󥹥��󥹤�����Υ᥽�åɤ�ƤӽФ��ޤ������θƤӽФ��ϡ�ɬ��ʸ���
��Ƭ������֤˹Ԥ��ޤ���

==== �᥽�å�:

�ä˵��Ҥ�̵���¤ꡢ�ƥ᥽�åɤϥǥե���ȤǤϲ��⤷�ޤ���

--- XMLScan::Visitor#parse_error(msg)

    ������§�˥ޥå����ʤ����������ȿ�ʳ��Υ��顼��ȯ����������
    �ƤӽФ���ޤ����ǥե���ȤǤ� ((<XMLScan::ParseError>))�㳰��
    ȯ�������ޤ����㳰�����������æ�Ф�Ԥ鷺�����̤������
    �ѡ������֤��ȡ��ѡ����ϥ��顼��������Ʋ��Ϥ�³���ޤ���

--- XMLScan::Visitor#wellformed_error(msg)

    �����������ȿ��ȯ���������˸ƤӽФ���ޤ����ǥե���ȤǤ�
    ((<XMLScan::NotWellFormedError>))�㳰��ȯ�������ޤ����㳰��������
    ���æ�Ф�Ԥ鷺�����̤������ѡ������֤��ȡ��ѡ����ϥ��顼��
    �������Ʋ��Ϥ�³���ޤ���

--- XMLScan::Visitor#valid_error(msg)

    �����������ȿ��ȯ���������˸ƤӽФ���ޤ����ǥե���ȤǤ�
    ((<XMLScan::NotValidError>))�㳰��ȯ�������ޤ����㳰��������
    ���æ�Ф�Ԥ鷺�����̤������ѡ������֤��ȡ��ѡ����ϥ��顼��
    �������Ʋ��Ϥ�³���ޤ���

    �ʤ������ߤ� xmlscan �ˤ��������򸡾ڤ���XML�ץ�����
    �ޤޤ�Ƥ��ޤ��󡣤��Υ᥽�åɤϾ�����ǤΤ����ͽ�󤵤�Ƥ��ޤ���

--- XMLScan::Visitor#warning(msg)

    ���顼�ǤϤʤ����侩����ʤ������䡢xmlscan �ǤϽ�ʬ�˲��ϤǤ��ʤ�
    ��ʸ��ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_start_document

    XMLʸ��β��Ϥ�Ϥ��ľ���˸ƤӽФ���ޤ������Υ᥽�åɤ��ƤӽФ��줿
    ��ˤ�ɬ�����б����� ((<XMLScan::Visitor#on_end_document>)) �᥽�åɤ�
    �ƤӽФ���ޤ���

--- XMLScan::Visitor#on_end_document

    XMLʸ��ν�ü�ޤǲ��Ϥ����ä���˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_xmldecl
--- XMLScan::Visitor#on_xmldecl_version(str)
--- XMLScan::Visitor#on_xmldecl_encoding(str)
--- XMLScan::Visitor#on_xmldecl_standalone(str)
--- XMLScan::Visitor#on_xmldecl_other(name, value)
--- XMLScan::Visitor#on_xmldecl_end

    XML�����ȯ���������˸ƤӽФ���ޤ���

        <?xml version="1.0" encoding="euc-jp" standalone="yes" ?>
        ^     ^             ^                 ^                ^
        1     2             3                 4                5

                     method                 argument
                 --------------------------------------
                  1: on_xmldecl
                  2: on_xmldecl_version     ("1.0")
                  3: on_xmldecl_encoding    ("euc-jp")
                  4: on_xmldecl_standalone  ("yes")
                  5: on_xmldecl_end

    XML�����ȯ��������硢on_xmldecl �� on_xmldecl_end ��ɬ��
    �ƤӽФ���ޤ���¾�Υ᥽�åɤ��б����빽ʸ��XML������
    ����ʤ��ä����ϸƤӽФ���ޤ���

    on_xmldecl_other �� version, encoding, standalone �ʳ��������
    XML�������ˤ��ä����˸ƤӽФ���ޤ������Τ褦������Ϲ�ʸ��
    ������Ƥ��ʤ����ᡢon_xmldecl_other ���ƤӽФ�������ˤ�ɬ��
    ((<XMLScan::Visitor#parse_error>)) �᥽�åɤ��ƤӽФ���뤳�Ȥ�
    ��դ��Ʋ�������

--- XMLScan::Visitor#on_doctype(root, pubid, sysid)

    ʸ�������ȯ���������˸ƤӽФ���ޤ���

             document                            argument
        --------------------------------------------------------------
         1: <!DOCTYPE foo>                      ('foo', nil,   nil)
         2: <!DOCTYPE foo SYSTEM "bar">         ('foo', nil,   'bar')
         3: <!DOCTYPE foo PUBLIC "bar">         ('foo', 'bar',  nil )
         4: <!DOCTYPE foo PUBLIC "bar" "baz">   ('foo', 'bar', 'baz')

--- XMLScan::Visitor#on_prolog_space(str)

    ���񤭤���˶����ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_comment(str)

    �����Ȥ�ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_pi(target, pi)

    ����̿���ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_chardata(str)

    ʸ���ǡ�����ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_cdata(str)

    CDATA����������ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_entityref(ref)

    °���ͤ���ʳ��ξ��ǰ��̼��λ��Ȥ�ȯ���������˸ƤӽФ���ޤ���

--- XMLScan::Visitor#on_charref(code)
--- XMLScan::Visitor#on_charref_hex(code)

    °���ͤ���ʳ��ξ���ʸ�����Ȥ�ȯ���������˸ƤӽФ���ޤ���
    ʸ�������ɤ�10�ʿ��ǻ��ꤵ��Ƥ������� on_charref��16�ʿ���
    ���ꤵ��Ƥ������� on_charref_hex ���ƤӽФ���ޤ���
    ((|code|))�������Ǥ���

--- XMLScan::Visitor#on_stag(name)
--- XMLScan::Visitor#on_attribute(name)
--- XMLScan::Visitor#on_attr_value(str)
--- XMLScan::Visitor#on_attr_entityref(ref)
--- XMLScan::Visitor#on_attr_charref(code)
--- XMLScan::Visitor#on_attr_charref_hex(code)
--- XMLScan::Visitor#on_attribute_end(name)
--- XMLScan::Visitor#on_stag_end_empty(name)
--- XMLScan::Visitor#on_stag_end(name)

    ���ϥ�����ȯ���������˸ƤӽФ���ޤ���

        <hoge fuga="foo&bar;&#38;&#x26;baz"  >
        ^     ^     ^  ^    ^    ^     ^  ^  ^
        1     2     3  4    5    6     7  8  9

             method                 argument
         ------------------------------------
          1: on_stag                ('hoge')
          2: on_attribute           ('fuga')
          3: on_attr_value          ('foo')
          4: on_attr_entityref      ('bar')
          5: on_attr_charref        (38)
          6: on_attr_charref_hex    (38)
          7: on_attr_value          ('baz')
          8: on_attribute_end       ('fuga')
          9: on_stag_end            ('hoge')
              or
             on_stag_end_empty      ('hoge')

    ���ϥ�����ȯ��������硢on_stag �ȡ��б����� on_stag_end ����
    on_stag_end_empty ��ɬ���ƤӽФ���ޤ���¾�Υ᥽�åɤϡ����ϥ�����
    ���°��������ʤ��ä����ϸƤӽФ���ޤ���

    °����ȯ��������硢on_attribute �� on_attribute_end ��ɬ��
    �ƤӽФ���ޤ���°���ͤ��� (fuga="") �λ��ϡ�����2�ĤΥ᥽�åɤΤߤ�
    �ƤӽФ���ޤ���

    on_attr_entityref ��°���ͤ���ǰ��̼��λ��Ȥ�ȯ����������
    �ƤӽФ���ޤ���on_charref �ڤ� on_charref_hex ��°���ͤ����
    ʸ�����Ȥ�ȯ���������˸ƤӽФ���ޤ���

    �����������ǥ������ä����ϡ�on_stag_end �᥽�åɤ������
    on_stag_end_empty �᥽�åɤ��ƤӽФ���ޤ���

--- XMLScan::Visitor#on_etag(name)

    ��λ������ȯ���������˸ƤӽФ���ޤ���



=== XMLScan::XMLScanner

XMLʸ��������Ϥ�����������ǧ�����륹����ʤǤ���

XMLScan::XMLScanner �ε���Ŭ�����ˤĤ��Ƥϡ�¾��ʸ��ǽҤ٤Ƥ��ޤ���

==== �����ѡ����饹:

* Object

==== ���饹�᥽�å�:

--- XMLScan::XMLScanner.new(visitor[, option ...])

    XMLScan::XMLScanner ���֥������Ȥ��������ޤ���((|visitor|))��
    XMLScan::Visitor �Υ��󥹥��󥹤ǡ�XMLScan::XMLScanner ���֥������Ȥ���
    ���Ϸ�̤�������ޤ���

    ((|option|))��ʸ�������ϥ���ܥ�ǻ��ꤷ�ޤ���option�ˤ�
    ���Τ�Τ�����ޤ���

    : 'strict_char'

        (({require 'xmlscan/xmlchar'})) ����Ȼ���Ǥ���褦�ˤʤ�ޤ���
        ������ʸ�����Ȥ��Ƥ��ʤ����ɤ����Υ����å���Ԥ��ޤ���
        �ѥե����ޥ󥹤��������㲼���ޤ���

==== �᥽�å�:

--- XMLScan::XMLScanner#kcode= arg

    CES����ꤷ�ޤ���((|arg|))�β��ϡ�nil ������� $KCODE ��Ʊ���Ǥ���
    ((|arg|))�� nil �ΤȤ��ϡ��ɤ� CES �ǲ��Ϥ�Ԥ����� $KCODE ���ͤˤ�ä�
    ��ޤ�ޤ���

--- XMLScan::XMLScanner#kcode

    �ɤ� CES �ǲ��Ϥ�Ԥ����� Regexp#kcode ��Ʊ���������֤��ޤ���
    nil�ΤȤ���$KCODE�˰�¸���뤳�Ȥ�ɽ���ޤ���

--- XMLScan::XMLScanner#parse(source)

    ((|source|)) ��XMLʸ��Ȥ��Ʋ��Ϥ��ޤ���((|source|)) ��ʸ����
    ʸ������������� IO#gets ��Ʊ�������񤤤򤹤� gets �᥽�åɤ����
    ���֥������ȤǤʤ���Фʤ�ޤ���


=== XMLScan::XMLParser

�������򸡾ڤ��ʤ� XML parser �Ǥ���

XMLScan::XMLParser �ε���Ŭ�����ˤĤ��Ƥϡ�¾��ʸ��ǽҤ٤Ƥ��ޤ���


==== �����ѡ����饹:

* ((<XMLScan::XMLScanner>))

==== ���饹�᥽�å�:

--- XMLScan::XMLParser.new(visitor[, option ...])

    XMLScan::XMLParser ���֥������Ȥ�((|visitor|))�γƥ᥽�åɤˤĤ��ơ�
    ���Τ��Ȥ��ݾڤ��ޤ���

    : ((<XMLScan::Visitor#on_stag>))

        ���Υ᥽�åɤ�ƤӽФ�����ˡ��б����� ((<XMLScan::Visitor#on_etag>))
        �᥽�åɤ�ɬ���ƤӽФ��ޤ���

    �ä��ơ����顼������Ԥ�ʤ���С���������XMLʸ��Ǥϵ��������ʤ�
    �᥽�åɸƤӽФ���������������ޤ���


=== XMLScan::HTMLScanner

((<XMLScan::XMLScanner>)) �򸵤ˤ��� HTML �ѡ����Ǥ���

XMLScan::HTMLScanner �ε���Ŭ�����ˤĤ��Ƥϡ�¾��ʸ��ǽҤ٤Ƥ��ޤ���

==== �����ѡ����饹:

* ((<XMLScan::XMLScanner>))

==== ���饹�᥽�å�:

--- XMLScan::HTMLScanner.new(visitor[, option ...])

    XMLScan::HTMLScanner ���֥������Ȥ�((|visitor|))�γƥ᥽�åɤˤĤ��ơ�
    ���Τ��Ȥ��ݾڤ��ޤ���

    : ((<XMLScan::Visitor#on_xmldecl>))
    : ((<XMLScan::Visitor#on_xmldecl_version>))
    : ((<XMLScan::Visitor#on_xmldecl_encoding>))
    : ((<XMLScan::Visitor#on_xmldecl_standalone>))
    : ((<XMLScan::Visitor#on_xmldecl_end>))

        HTML �ˤ� XML�����¸�ߤ��ʤ��Τǡ������Υ᥽�åɤ�ƤӽФ����Ȥ�
        ����ޤ���

    : ((<XMLScan::Visitor#on_stag_end_empty>))

        HTML �ˤ϶����ǥ�����¸�ߤ��ʤ��Τǡ����Υ᥽�åɤ�ƤӽФ����Ȥ�
        ����ޤ��󡣶����ǥ����ϲ��ϥ��顼�ˤʤ�ޤ���

    : ((<XMLScan::Visitor#wellformed_error>))

        HTML �ˤ�����������¸�ߤ��ʤ��Τǡ����Υ᥽�åɤ�ƤӽФ����Ȥ�
        ����ޤ���

=end

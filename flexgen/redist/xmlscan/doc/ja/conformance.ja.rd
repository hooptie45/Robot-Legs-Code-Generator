=begin
# $Id: conformance.rd.src,v 1.1 2003/01/22 16:41:45 katsu Exp $

= xmlscan �ε��ʤؤ�Ŭ����

����ʸ��Ǥϡ�xmlscan �˴ޤޤ��ƥѡ����� XML ��Ϣ���ʤؤ�
Ŭ�����ˤĤ��ƽҤ٤ޤ���

== ����

xmlscan �� XML 1.0 Sepcification ((<[XML]>)) �Ǥ����Ȥ����
���������򸡾ڤ��ʤ��ץ����פǤ����������򸡾ڤ��ʤ��ץ�����
��������ΤۤȤ�ɤ��������Ƥ��ޤ������������Թ�塢���
���Τ褦�����󤬤���ޤ����ܺ٤ϳƥ��饹��ε��Ҥ򻲾Ȥ��Ƥ���������

 * UTF-16 �ǽ񤫤줿XMLʸ���ľ�ܲ��ϤǤ��ޤ���
 * �ǥե���ȤǤϡ�XMLʸ����ǡ����Ϥ���ʸ̮�ǻ��Ѥ�ǧ����ʤ�
   ʸ�����ޤޤ�Ƥ��ʤ����Ȥ򸡺����ޤ���
 * �����볰�����Τ��ɤ߹��ߤޤ��󡣳��������оݼ��Τ˴ؤ���
   ����������ϥ����å�����ޤ���
 * ����DTD���֥��åȤ��ɤ����Ф��ޤ� (����ΥС������ǥ��ݡ���ͽ��)��
   DTD�˴ؤ�������������ϥ����å�����ޤ���


== XMLScan::XMLScanner �ε��ʤؤ�Ŭ����

XMLScan::XMLScanner ��XMLʸ�����Ϥ���XML�����ʸ�����������̿�ᡢ
�����ȡ����ϥ�������λ�����������ǥ�����CDATA��������󡢰��̼��λ��ȡ�
�����ʸ�����Ȥ�ǧ�ΤΤߤ�Ԥ��ޤ����ʲ��˽Ҥ٤��������ơ�
����餬����ƤϤʤ�ʤ�ʸ̮�Ǹ��줿�Ȥ��Ƥ⡢���顼�ˤʤ�ޤ���

XML�����ʸ����� (����DTD���֥��åȤ����)������̿�ᡢ�����ȡ�
���ϥ�������λ�����������ǥ�����CDATA��������󡢰��̼��λ��ȡ������
ʸ�����Ȥ� XML 1.0 Specification ((<[XML]>)) ������������§��
�ޥå����ʤ���硢���ϥ��顼�Ȥʤ�ޤ���

����Ū�ʽ���®�٤����뤿�ᡢstrict_char ���ץ���󤬻��ꤵ��Ƥ��ʤ�
��硢̾����ʸ���ǡ������˻��Ѥ�ǧ����ʤ�ʸ�����ޤޤ�Ƥ��ʤ����Ȥ�
�������ޤ��󡣤���ʸ̮�Ƕ��ڤ�ҤȤ���ǧ�������٤�ʸ������������Ƥ�
ʸ������ǧ����ޤ�������Ū�ˤϡ�strict_char ���ץ���󤬻��ꤵ���
���ʤ���С�������§ Char[2], Name[5], Nmtoken[7], EntityValue[9],
AttValue[10], SystemLiteral[11], PubidChar[13], CharData[14],
VersionNum[26], EncName[81] �ϸ�̩�˥����å�����ޤ���

��������������Ԥ��ޤ���

Ruby ���Τ����ݡ��Ȥ��Ƥ��ʤ����ᡢUTF-16 �ǽ񤫤줿ʸ���
ľ�ܲ��Ϥ��뤳�ȤϤǤ��ޤ��󡣲������˰�ö UTF-8 ���Ѵ�����
ɬ�פ�����ޤ���

ʸ�����Ƭ�ʳ��� `<?xml' �����줿���ϡ���������̿��Ȥߤʤ��ޤ���

������ɥ����ʸ������� yes �ޤ��� no �Ǥ��뤫������å����ޤ���

����̿��Υ������åȤ� xml �Ǥʤ����Ȥ�����å����ޤ���

ʸ����������񤭰ʳ��˸��줿��硢�ޤ�2��ʾ帽�줿����
���ϥ��顼�Ȥʤ�ޤ���

°���ͤ���� `<' ��ʸ����ľ�ܸ��줿��硢�����������ȿ���顼��
�ʤ�ޤ���strict_char ���ץ���󤬻��ꤵ��Ƥ����硢����������
"Legal Character" ������å����ޤ�������ʳ�������������Ϥޤä���
�����å�����ޤ���

����DTD���֥��åȤ��ɤ����Ф��ޤ���


== XMLScan::XMLParser �ε��ʤؤ�Ŭ����

XMLScan::XMLParser �ϡ��������򸡾ڤ��ʤ�XML�ץ����Ȥ��Ƶ�����
���ΤۤȤ�����Ƥ����������Ȥ���ɸ�ˤ��Ƥ��ޤ���

XMLScan::XMLScanner �� strict_char ���ץ����˴ؤ��뵭�ҡ��ڤ�
UTF-16 �˴ؤ��뵭�Ҥϡ����Τޤ� XMLScan::XMLParser �ˤ����ƤϤޤ�ޤ���
ʸ�����Ȥ˴ؤ���ʲ�������ϡ�strict_char ���ץ���󤬻��ꤵ�줿
���Τߥ����å�����ޤ���

 * Well-formedness constraint: Legal Character

��������������Ԥ��ޤ���

����DTD���֥��åȤ��ɤ����Ф��ޤ�������DTD���֥��åȤ˴ؤ���ʲ���
����������ϥ����å�����ޤ���

 * Well-formedness constraint: PEs in Internal Subset
 * Well-formedness constraint: PE Between Declarations
 * Well-formedness constraint: No External Entity References
 * Well-formedness constraint: Entity Declared
 * Well-formedness constraint: Parsed Entity
 * Well-formedness constraint: No Recursion
 * Well-formedness constraint: In DTD

����Ѥ߼��� (lt,gt,amp,quot,apos) ��������Ƥΰ��̼��λ��Ȥϡ�
������ɤ߹��ޤ�Ƥ��ʤ����Τؤλ��ȤȤ�����𤵤�ޤ���

����DTD���֥��åȤϼ����ߤޤ��󡣳���DTD���֥��åȤ˴ؤ���ʲ���
����������ϥ����å�����ޤ���

 * Well-formedness constraint: External Subset

������ɤ߹���Ǥ��ʤ����Τ��ִ��ƥ����Ȥ� < ���ޤޤ�Ƥ��뤳�Ȥ�
��ǧ�Ǥ��ʤ����ᡢ�ʲ�������������ϥ����å�����ޤ���

 * Well-formedness constraint: No < in Attribute Values


== XMLScan::XMLNamespace �ε��ʤؤ�Ŭ����

XMLScan::XMLNamespace �� Namespaces in XML �ڤӤ��� errata ((<[Namespaces]>))
�����������Ƥ����������å����� XML ʸ��̾������������
(namespace-well-formed) �Ǥ��뤳�Ȥ��ǧ���ޤ���

XMLScan::XMLParser �˵����������¤ϡ����Τޤ� XMLScan::XMLNamespace
�ˤ�Ѿ�����ޤ���


== ����ʸ��

: [XML]
    W3C (World Wide Web Consortium).
    Extensible Markup Language (XML) 1.0 (Second Edition),
    January 2000.
    ((<URL:http://www.w3.org/TR/2000/REC-xml-20001006>))

: [Namespaces]
    W3C (World Wide Web Consortium).
    Namespaces in XML,
    January 1999.
    ((<URL:http://www.w3.org/TR/1999/REC-xml-names-19990114>)).
    ���פ������� ((<URL:http://www.w3.org/XML/xml-names-19990114-errata>))
    �˴ޤޤ�Ƥ���.


=end

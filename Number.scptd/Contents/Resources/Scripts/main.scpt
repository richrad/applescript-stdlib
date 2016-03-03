FasdUAS 1.101.10   ��   ��    k             l      ��  ��   pj Number -- manipulate numeric values and perform common math functions

Notes:

- The Trigonometry and Logarithm handlers are slightly modified versions of handlers found in ESG MathLib <http://www.esglabs.com/>, which in turn are conversions of functions in the Cephes Mathematical Library by Stephen L. Moshier <http://netlib.org/cephes/>.

- see <http://www.unicode.org/reports/tr35/tr35-31/tr35-numbers.html#Number_Format_Patterns> for recognized format patterns when passing text values as `parse/format number`'s `using` parameter

TO DO: 

- debug, finalize `parse/format number` behaviors

- should `tan` return `infinity` symbol instead of erroring?

- use identifiers rather than properties in number format record? (other libraries already do this to mimimize namespace pollution)

- support `NSNumberFormatterOrdinalStyle`, `NSNumberFormatterCurrencyISOCodeStyle `, etc (10.11+) in `parse/format number`?

- -[NSNumberFormatter setMinimumFractionDigits:] may be buggy; see notes in _setBasicFormat()

- in `format number`, any way to include "+" sign for exponent, same as AS? (e.g. "1.0E+8" rather than "1.0E8")
				
     � 	 	�   N u m b e r   - -   m a n i p u l a t e   n u m e r i c   v a l u e s   a n d   p e r f o r m   c o m m o n   m a t h   f u n c t i o n s 
 
 N o t e s : 
 
 -   T h e   T r i g o n o m e t r y   a n d   L o g a r i t h m   h a n d l e r s   a r e   s l i g h t l y   m o d i f i e d   v e r s i o n s   o f   h a n d l e r s   f o u n d   i n   E S G   M a t h L i b   < h t t p : / / w w w . e s g l a b s . c o m / > ,   w h i c h   i n   t u r n   a r e   c o n v e r s i o n s   o f   f u n c t i o n s   i n   t h e   C e p h e s   M a t h e m a t i c a l   L i b r a r y   b y   S t e p h e n   L .   M o s h i e r   < h t t p : / / n e t l i b . o r g / c e p h e s / > . 
 
 -   s e e   < h t t p : / / w w w . u n i c o d e . o r g / r e p o r t s / t r 3 5 / t r 3 5 - 3 1 / t r 3 5 - n u m b e r s . h t m l # N u m b e r _ F o r m a t _ P a t t e r n s >   f o r   r e c o g n i z e d   f o r m a t   p a t t e r n s   w h e n   p a s s i n g   t e x t   v a l u e s   a s   ` p a r s e / f o r m a t   n u m b e r ` ' s   ` u s i n g `   p a r a m e t e r 
 
 T O   D O :   
 
 -   d e b u g ,   f i n a l i z e   ` p a r s e / f o r m a t   n u m b e r `   b e h a v i o r s 
 
 -   s h o u l d   ` t a n `   r e t u r n   ` i n f i n i t y `   s y m b o l   i n s t e a d   o f   e r r o r i n g ? 
 
 -   u s e   i d e n t i f i e r s   r a t h e r   t h a n   p r o p e r t i e s   i n   n u m b e r   f o r m a t   r e c o r d ?   ( o t h e r   l i b r a r i e s   a l r e a d y   d o   t h i s   t o   m i m i m i z e   n a m e s p a c e   p o l l u t i o n ) 
 
 -   s u p p o r t   ` N S N u m b e r F o r m a t t e r O r d i n a l S t y l e ` ,   ` N S N u m b e r F o r m a t t e r C u r r e n c y I S O C o d e S t y l e   ` ,   e t c   ( 1 0 . 1 1 + )   i n   ` p a r s e / f o r m a t   n u m b e r ` ? 
 
 -   - [ N S N u m b e r F o r m a t t e r   s e t M i n i m u m F r a c t i o n D i g i t s : ]   m a y   b e   b u g g y ;   s e e   n o t e s   i n   _ s e t B a s i c F o r m a t ( ) 
 
 -   i n   ` f o r m a t   n u m b e r ` ,   a n y   w a y   t o   i n c l u d e   " + "   s i g n   f o r   e x p o n e n t ,   s a m e   a s   A S ?   ( e . g .   " 1 . 0 E + 8 "   r a t h e r   t h a n   " 1 . 0 E 8 " ) 
 	 	 	 	 
   
  
 l     ��������  ��  ��        l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -     !   l     �� " #��   "   support    # � $ $    s u p p o r t !  % & % l     ��������  ��  ��   &  ' ( ' l      ) * + ) j    �� ,�� 0 _support   , N     - - 4    �� .
�� 
scpt . m     / / � 0 0  T y p e S u p p o r t * "  used for parameter checking    + � 1 1 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g (  2 3 2 l     ��������  ��  ��   3  4 5 4 i   ! 6 7 6 I      �� 8���� 
0 _error   8  9 : 9 o      ���� 0 handlername handlerName :  ; < ; o      ���� 0 etext eText <  = > = o      ���� 0 enumber eNumber >  ? @ ? o      ���� 0 efrom eFrom @  A�� A o      ���� 
0 eto eTo��  ��   7 n     B C B I    �� D���� &0 throwcommanderror throwCommandError D  E F E m     G G � H H  N u m b e r F  I J I o    ���� 0 handlername handlerName J  K L K o    ���� 0 etext eText L  M N M o    	���� 0 enumber eNumber N  O P O o   	 
���� 0 efrom eFrom P  Q�� Q o   
 ���� 
0 eto eTo��  ��   C o     ���� 0 _support   5  R S R l     ��������  ��  ��   S  T U T l     ��������  ��  ��   U  V W V l     �� X Y��   X J D--------------------------------------------------------------------    Y � Z Z � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - W  [ \ [ l     �� ] ^��   ]  
 constants    ^ � _ _    c o n s t a n t s \  ` a ` l     ��������  ��  ��   a  b c b l      d e f d j   " $�� g�� 	0 __e__   g m   " # h h @�
�_� e ; 5 the mathematical constant e (natural logarithm base)    f � i i j   t h e   m a t h e m a t i c a l   c o n s t a n t   e   ( n a t u r a l   l o g a r i t h m   b a s e ) c  j k j l     ��������  ��  ��   k  l m l l      n o p n j   % '�� q�� 0 _isequaldelta _isEqualDelta q m   % & r r =q���-� o i c multiplier used by `cmp` to allow for slight differences due to floating point's limited precision    p � s s �   m u l t i p l i e r   u s e d   b y   ` c m p `   t o   a l l o w   f o r   s l i g h t   d i f f e r e n c e s   d u e   t o   f l o a t i n g   p o i n t ' s   l i m i t e d   p r e c i s i o n m  t u t l     ��������  ��  ��   u  v w v l     �� x y��   x � � [positive] numeric range within which `basic format` uses decimal rather than scientific notation when formatting reals (this mimics AS's own behavior); the corresponding negative range is calcuated automatically    y � z z�   [ p o s i t i v e ]   n u m e r i c   r a n g e   w i t h i n   w h i c h   ` b a s i c   f o r m a t `   u s e s   d e c i m a l   r a t h e r   t h a n   s c i e n t i f i c   n o t a t i o n   w h e n   f o r m a t t i n g   r e a l s   ( t h i s   m i m i c s   A S ' s   o w n   b e h a v i o r ) ;   t h e   c o r r e s p o n d i n g   n e g a t i v e   r a n g e   i s   c a l c u a t e d   a u t o m a t i c a l l y w  { | { j   ( *�� }�� $0 _mindecimalrange _minDecimalRange } m   ( ) ~ ~ ?PbM��� |   �  j   + -�� ��� $0 _maxdecimalrange _maxDecimalRange � m   + , � � @È      �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   parse and format    � � � � "   p a r s e   a n d   f o r m a t �  � � � l     ��������  ��  ��   �  � � � i  . 1 � � � I      �� ����� (0 _asintegerproperty _asIntegerProperty �  � � � o      ���� 0 thevalue theValue �  � � � o      ���� 0 propertyname propertyName �  ��� � o      ���� 0 minvalue minValue��  ��   � l    8 � � � � Q     8 � � � � k    & � �  � � � r     � � � c     � � � o    ���� 0 thevalue theValue � m    ��
�� 
long � o      ���� 0 n   �  � � � Z  	 # � ����� � G   	  � � � >   	  � � � o   	 
���� 0 n   � c   
  � � � o   
 ���� 0 thevalue theValue � m    ��
�� 
doub � A     � � � o    ���� 0 n   � o    ���� 0 minvalue minValue � R    ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � m    �����Y��  ��  ��   �  ��� � L   $ & � � o   $ %���� 0 n  ��   � R      ���� �
�� .ascrerr ****      � ****��   � �� ���
�� 
errn � d       � � m      �������   � R   . 8�� � �
�� .ascrerr ****      � **** � b   2 7 � � � b   2 5 � � � m   2 3 � � � � � J  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    � o   3 4���� 0 propertyname propertyName � m   5 6 � � � � � P    p r o p e r t y   i s   n o t   a   n o n - n e g a t i v e   i n t e g e r � �� ���
�� 
errn � m   0 1�����Y��   � . ( TO DO: what about sensible upper bound?    � � � � P   T O   D O :   w h a t   a b o u t   s e n s i b l e   u p p e r   b o u n d ? �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � i  2 5 � � � I      �� ����� ,0 _makenumberformatter _makeNumberFormatter �  � � � o      ���� 0 formatstyle formatStyle �  � � � o      ���� 0 
localecode 
localeCode �  ��� � o      ���� 0 	thenumber 	theNumber��  ��   � l   � � � � � k    � � �  � � � l     � � � � r      � � � n     � � � I    �������� 0 init  ��  ��   � n     � � � I    ��~�}� 	0 alloc  �~  �}   � n     � � � o    �|�| &0 nsnumberformatter NSNumberFormatter � m     �{
�{ misccura � o      �z�z 0 asocformatter asocFormatter �	 (note that while NSFormatter provides a global +setDefaultFormatterBehavior: option to change all NSNumberFormatters to use pre-10.4 behavior, we don't bother to call setFormatterBehavior: as it's very unlikely nowadays that a host process would change this)    � � � �   ( n o t e   t h a t   w h i l e   N S F o r m a t t e r   p r o v i d e s   a   g l o b a l   + s e t D e f a u l t F o r m a t t e r B e h a v i o r :   o p t i o n   t o   c h a n g e   a l l   N S N u m b e r F o r m a t t e r s   t o   u s e   p r e - 1 0 . 4   b e h a v i o r ,   w e   d o n ' t   b o t h e r   t o   c a l l   s e t F o r m a t t e r B e h a v i o r :   a s   i t ' s   v e r y   u n l i k e l y   n o w a d a y s   t h a t   a   h o s t   p r o c e s s   w o u l d   c h a n g e   t h i s ) �  � � � Q   � � � � � Z   w � ��y � � =     � � � l    ��x�w � I   �v � �
�v .corecnte****       **** � J     � �  ��u � o    �t�t 0 formatstyle formatStyle�u   � �s ��r
�s 
kocl � m    �q
�q 
reco�r  �x  �w   � m    �p�p  � k   [ � �  � � � r    P � � � n   N � � � I   $ N�o �n�o 60 asoptionalrecordparameter asOptionalRecordParameter   o   $ %�m�m 0 formatstyle formatStyle  K   % G �l
�l 
pcls l  & '�k�j m   & '�i
�i 
MthR�k  �j   �h	

�h 
MthA	 n  ( / o   - /�g�g 0 requiredvalue RequiredValue o   ( -�f�f 0 _support  
 �e
�e 
MthB m   0 1�d
�d 
msng �c
�c 
MthC m   2 3�b
�b 
msng �a
�a 
MthD m   4 5�`
�` 
msng �_
�_ 
MthE m   6 7�^
�^ 
msng �]
�] 
MthF m   : ;�\
�\ 
msng �[
�[ 
MthG m   > ?�Z
�Z 
msng �Y�X
�Y 
MthH m   B C�W
�W 
msng�X   �V m   G J � 
 u s i n g�V  �n   � o    $�U�U 0 _support   � o      �T�T 0 formatrecord formatRecord �  I   Q [�S�R�S "0 _setbasicformat _setBasicFormat  !  o   R S�Q�Q 0 asocformatter asocFormatter! "#" n  S V$%$ 1   T V�P
�P 
MthA% o   S T�O�O 0 formatrecord formatRecord# &�N& o   V W�M�M 0 	thenumber 	theNumber�N  �R   '(' Z   \ �)*�L�K) >  \ a+,+ n  \ _-.- 1   ] _�J
�J 
MthB. o   \ ]�I�I 0 formatrecord formatRecord, m   _ `�H
�H 
msng* k   d �// 010 n  d u232 I   e u�G4�F�G 60 setminimumfractiondigits_ setMinimumFractionDigits_4 5�E5 I   e q�D6�C�D (0 _asintegerproperty _asIntegerProperty6 787 n  f i9:9 1   g i�B
�B 
MthB: o   f g�A�A 0 formatrecord formatRecord8 ;<; m   i l== �>> , m i n i m u m   d e c i m a l   p l a c e s< ?�@? m   l m�?�?  �@  �C  �E  �F  3 o   d e�>�> 0 asocformatter asocFormatter1 @A@ l  v ~BCDB n  v ~EFE I   w ~�=G�<�= 60 setmaximumfractiondigits_ setMaximumFractionDigits_G H�;H m   w z�:�:��;  �<  F o   v w�9�9 0 asocformatter asocFormatterC L F kludge for NSNumberFormatterBug; see notes in _setBasicFormat() below   D �II �   k l u d g e   f o r   N S N u m b e r F o r m a t t e r B u g ;   s e e   n o t e s   i n   _ s e t B a s i c F o r m a t ( )   b e l o wA J�8J l   �7KL�7  KasocFormatter's setAlwaysShowsDecimalSeparator:true -- note: doesn't work well when significant digits are specified (may leave hanging separator char with no "0" after it), but doesn't seem to be essential when fraction digits are already specified, so just disable/omit it   L �MM$ a s o c F o r m a t t e r ' s   s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e   - -   n o t e :   d o e s n ' t   w o r k   w e l l   w h e n   s i g n i f i c a n t   d i g i t s   a r e   s p e c i f i e d   ( m a y   l e a v e   h a n g i n g   s e p a r a t o r   c h a r   w i t h   n o   " 0 "   a f t e r   i t ) ,   b u t   d o e s n ' t   s e e m   t o   b e   e s s e n t i a l   w h e n   f r a c t i o n   d i g i t s   a r e   a l r e a d y   s p e c i f i e d ,   s o   j u s t   d i s a b l e / o m i t   i t�8  �L  �K  ( NON Z   � �PQ�6�5P >  � �RSR n  � �TUT 1   � ��4
�4 
MthCU o   � ��3�3 0 formatrecord formatRecordS m   � ��2
�2 
msngQ k   � �VV WXW n  � �YZY I   � ��1[�0�1 60 setmaximumfractiondigits_ setMaximumFractionDigits_[ \�/\ I   � ��.]�-�. (0 _asintegerproperty _asIntegerProperty] ^_^ n  � �`a` 1   � ��,
�, 
MthCa o   � ��+�+ 0 formatrecord formatRecord_ bcb m   � �dd �ee , m a x i m u m   d e c i m a l   p l a c e sc f�*f m   � ��)�)  �*  �-  �/  �0  Z o   � ��(�( 0 asocformatter asocFormatterX g�'g l  � ��&hi�&  h B <asocFormatter's setAlwaysShowsDecimalSeparator:true -- ditto   i �jj x a s o c F o r m a t t e r ' s   s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e   - -   d i t t o�'  �6  �5  O klk Z   � �mn�%�$m >  � �opo n  � �qrq 1   � ��#
�# 
MthDr o   � ��"�" 0 formatrecord formatRecordp m   � ��!
�! 
msngn k   � �ss tut n  � �vwv I   � �� x��  <0 setminimumsignificantdigits_ setMinimumSignificantDigits_x y�y I   � ��z�� (0 _asintegerproperty _asIntegerPropertyz {|{ n  � �}~} 1   � ��
� 
MthD~ o   � ��� 0 formatrecord formatRecord| � m   � ��� ��� 4 m i n i m u m   s i g n i f i c a n t   d i g i t s� ��� m   � ���  �  �  �  �  w o   � ��� 0 asocformatter asocFormatteru ��� n  � ���� I   � ����� 60 setusessignificantdigits_ setUsesSignificantDigits_� ��� m   � ��
� boovtrue�  �  � o   � ��� 0 asocformatter asocFormatter�  �%  �$  l ��� Z   � ������ >  � ���� n  � ���� 1   � ��
� 
MthE� o   � ��� 0 formatrecord formatRecord� m   � ��
� 
msng� k   � ��� ��� n  � ���� I   � ����
� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_� ��	� I   � ����� (0 _asintegerproperty _asIntegerProperty� ��� n  � ���� 1   � ��
� 
MthE� o   � ��� 0 formatrecord formatRecord� ��� m   � ��� ��� 4 m a x i m u m   s i g n i f i c a n t   d i g i t s� ��� m   � ���  �  �  �	  �
  � o   � ��� 0 asocformatter asocFormatter� ��� n  � ���� I   � �� ����  60 setusessignificantdigits_ setUsesSignificantDigits_� ���� m   � ���
�� boovtrue��  ��  � o   � ����� 0 asocformatter asocFormatter�  �  �  � ��� Z   �?������� >  � ���� n  � ���� 1   � ���
�� 
MthF� o   � ����� 0 formatrecord formatRecord� m   � ���
�� 
msng� Q   �;���� k   �'�� ��� r   ���� c   ���� n  ���� 1   ���
�� 
MthF� o   � ����� 0 formatrecord formatRecord� m  ��
�� 
ctxt� o      ���� 0 s  � ��� Z  ������� =  ��� n ��� 1  	��
�� 
leng� o  	���� 0 s  � m  ����  � R  �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  �����Y��  ��  ��  � ���� n !'��� I  "'������� ,0 setdecimalseparator_ setDecimalSeparator_� ���� o  "#���� 0 s  ��  ��  � o  !"���� 0 asocformatter asocFormatter��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � R  /;����
�� .ascrerr ****      � ****� m  7:�� ��� �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    d e c i m a l   s e p a r a t o r    p r o p e r t y   i s   n o t   n o n - e m p t y   t e x t� �����
�� 
errn� m  36�����Y��  ��  ��  � ��� Z  @�������� > @G��� n @E��� 1  AE��
�� 
MthG� o  @A���� 0 formatrecord formatRecord� m  EF��
�� 
msng� Q  J����� k  My�� ��� r  MX��� c  MV��� n MR��� 1  NR��
�� 
MthG� o  MN���� 0 formatrecord formatRecord� m  RU��
�� 
ctxt� o      ���� 0 s  � ���� Z  Yy������ =  Y`��� n Y^��� 1  Z^��
�� 
leng� o  YZ���� 0 s  � m  ^_����  � n ci��� I  di������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  de��
�� boovfals��  ��  � o  cd���� 0 asocformatter asocFormatter��  � k  ly�� ��� n lr��� I  mr������� 60 setusesgroupingseparator_ setUsesGroupingSeparator_� ���� m  mn��
�� boovtrue��  ��  � o  lm���� 0 asocformatter asocFormatter� ���� n sy��� I  ty������� .0 setgroupingseparator_ setGroupingSeparator_� ���� o  tu���� 0 s  ��  ��  � o  st���� 0 asocformatter asocFormatter��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d         m      �������  � R  ����
�� .ascrerr ****      � **** m  �� � �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    g r o u p i n g   s e p a r a t o r    p r o p e r t y   i s   n o t   t e x t ����
�� 
errn m  �������Y��  ��  ��  � �� Z  �[���� > ��	
	 n �� 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord
 m  ����
�� 
msng Z  �W = �� n �� 1  ����
�� 
MthH o  ������ 0 formatrecord formatRecord l ������ m  ����
�� MRndRNhE��  ��   n �� I  �������� $0 setroundingmode_ setRoundingMode_ �� l ������ n �� o  ������ @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven m  ����
�� misccura��  ��  ��  ��   o  ������ 0 asocformatter asocFormatter  = ��  n ��!"! 1  ����
�� 
MthH" o  ������ 0 formatrecord formatRecord  l ��#����# m  ����
�� MRndRNhT��  ��   $%$ n ��&'& I  ����(���� $0 setroundingmode_ setRoundingMode_( )��) l ��*����* n ��+,+ o  ������ @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown, m  ����
�� misccura��  ��  ��  ��  ' o  ������ 0 asocformatter asocFormatter% -.- = ��/0/ n ��121 1  ����
�� 
MthH2 o  ������ 0 formatrecord formatRecord0 l ��3����3 m  ����
�� MRndRNhF��  ��  . 454 n ��676 I  ����8���� $0 setroundingmode_ setRoundingMode_8 9��9 l ��:����: n ��;<; o  ������ <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp< m  ����
�� misccura��  ��  ��  ��  7 o  ������ 0 asocformatter asocFormatter5 =>= = ��?@? n ��ABA 1  ����
�� 
MthHB o  ������ 0 formatrecord formatRecord@ l ��C����C m  ����
�� MRndRN_T��  ��  > DED n ��FGF I  ����H��� $0 setroundingmode_ setRoundingMode_H I�~I l ��J�}�|J n ��KLK o  ���{�{ 80 nsnumberformatterrounddown NSNumberFormatterRoundDownL m  ���z
�z misccura�}  �|  �~  �  G o  ���y�y 0 asocformatter asocFormatterE MNM =  	OPO n  QRQ 1  �x
�x 
MthHR o   �w�w 0 formatrecord formatRecordP l S�v�uS m  �t
�t MRndRN_F�v  �u  N TUT n VWV I  �sX�r�s $0 setroundingmode_ setRoundingMode_X Y�qY l Z�p�oZ n [\[ o  �n�n 40 nsnumberformatterroundup NSNumberFormatterRoundUp\ m  �m
�m misccura�p  �o  �q  �r  W o  �l�l 0 asocformatter asocFormatterU ]^] = "_`_ n aba 1  �k
�k 
MthHb o  �j�j 0 formatrecord formatRecord` l !c�i�hc m  !�g
�g MRndRN_U�i  �h  ^ ded n %/fgf I  &/�fh�e�f $0 setroundingmode_ setRoundingMode_h i�di l &+j�c�bj n &+klk o  '+�a�a >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeilingl m  &'�`
�` misccura�c  �b  �d  �e  g o  %&�_�_ 0 asocformatter asocFormattere mnm = 2;opo n 27qrq 1  37�^
�^ 
MthHr o  23�]�] 0 formatrecord formatRecordp l 7:s�\�[s m  7:�Z
�Z MRndRN_D�\  �[  n t�Yt n >Huvu I  ?H�Xw�W�X $0 setroundingmode_ setRoundingMode_w x�Vx l ?Dy�U�Ty n ?Dz{z o  @D�S�S :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor{ m  ?@�R
�R misccura�U  �T  �V  �W  v o  >?�Q�Q 0 asocformatter asocFormatter�Y   R  KW�P|}
�P .ascrerr ****      � ****| m  SV~~ � �  n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d  s    r o u n d i n g   b e h a v i o r    i s   n o t   a n   a l l o w e d   c o n s t a n t} �O��N
�O 
errn� m  OR�M�M�Y�N  ��  ��  ��  �y   � Q  ^w���� I  ai�L��K�L "0 _setbasicformat _setBasicFormat� ��� o  bc�J�J 0 asocformatter asocFormatter� ��� o  cd�I�I 0 formatstyle formatStyle� ��H� o  de�G�G 0 	thenumber 	theNumber�H  �K  � R      �F�E�
�F .ascrerr ****      � ****�E  � �D��C
�D 
errn� d      �� m      �B�B��C  � R  qw�A��@
�A .ascrerr ****      � ****� m  sv�� ��� | n o t   a    n u m b e r   f o r m a t   d e f i n i t i o n    r e c o r d   o r   a n   a l l o w e d   c o n s t a n t�@   � R      �?��
�? .ascrerr ****      � ****� o      �>�> 0 etext eText� �=��<
�= 
errn� d      �� m      �;�;��<   � n ���� I  ���:��9�: .0 throwinvalidparameter throwInvalidParameter� ��� o  ���8�8 0 formatstyle formatStyle� ��� m  ���� ��� 
 u s i n g� ��� J  ���� ��� m  ���7
�7 
reco� ��6� m  ���5
�5 
enum�6  � ��4� o  ���3�3 0 etext eText�4  �9  � o  ��2�2 0 _support   � ��� n ����� I  ���1��0�1 0 
setlocale_ 
setLocale_� ��/� l ����.�-� n ����� I  ���,��+�, *0 asnslocaleparameter asNSLocaleParameter� ��� o  ���*�* 0 
localecode 
localeCode� ��)� m  ���� ���  f o r   l o c a l e�)  �+  � o  ���(�( 0 _support  �.  �-  �/  �0  � o  ���'�' 0 asocformatter asocFormatter� ��&� L  ���� o  ���%�% 0 asocformatter asocFormatter�&   � � � theNumber is either the number being formatted or `missing value` when parsing; determines appropriate formatting style based on number's type and value when `native format` is specified    � ���v   t h e N u m b e r   i s   e i t h e r   t h e   n u m b e r   b e i n g   f o r m a t t e d   o r   ` m i s s i n g   v a l u e `   w h e n   p a r s i n g ;   d e t e r m i n e s   a p p r o p r i a t e   f o r m a t t i n g   s t y l e   b a s e d   o n   n u m b e r ' s   t y p e   a n d   v a l u e   w h e n   ` n a t i v e   f o r m a t `   i s   s p e c i f i e d � ��� l     �$�#�"�$  �#  �"  � ��� l     �!� ��!  �   �  � ��� i  6 9��� I      ���� "0 _setbasicformat _setBasicFormat� ��� o      �� 0 asocformatter asocFormatter� ��� o      �� 0 
formatname 
formatName� ��� o      �� 0 	thenumber 	theNumber�  �  � Z    F����� =    ��� o     �� 0 
formatname 
formatName� m    �
� MthZMth0� Z    ������ =   	��� o    �� 0 	thenumber 	theNumber� m    �
� 
msng� l   ���� n   ��� I    ���� "0 setnumberstyle_ setNumberStyle_� ��� l   ���� n   ��� o    �� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� m    �
� misccura�  �  �  �  � o    �� 0 asocformatter asocFormatter� ? 9 parsing always recognizes scientific notation by default   � ��� r   p a r s i n g   a l w a y s   r e c o g n i z e s   s c i e n t i f i c   n o t a t i o n   b y   d e f a u l t�  � l   ����� Z    ������ =   ��� n   ��� m    �
� 
pcls� o    �
�
 0 	thenumber 	theNumber� m    �	
�	 
long� l   '���� n   '��� I     '���� "0 setnumberstyle_ setNumberStyle_� ��� l    #���� n    #��� o   ! #�� 40 nsnumberformatternostyle NSNumberFormatterNoStyle� m     !�
� misccura�  �  �  �  � o     �� 0 asocformatter asocFormatter�   format integer   � ���    f o r m a t   i n t e g e r� ��� G   * _��� G   * W��� l 
 * ?�� ��� l  * ?������ F   * ?��� A   * 2��� d   * 0�� o   * /���� $0 _maxdecimalrange _maxDecimalRange� o   0 1���� 0 	thenumber 	theNumber� A   5 =��� o   5 6���� 0 	thenumber 	theNumber� d   6 <�� o   6 ;���� $0 _mindecimalrange _minDecimalRange��  ��  �   ��  � l 
 B U ����  l  B U���� F   B U A   B I o   B G���� $0 _mindecimalrange _minDecimalRange o   G H���� 0 	thenumber 	theNumber A   L S o   L M���� 0 	thenumber 	theNumber o   M R���� $0 _maxdecimalrange _maxDecimalRange��  ��  ��  ��  � =   Z ]	 o   Z [���� 0 	thenumber 	theNumber	 m   [ \����  � 
��
 l  b � k   b �  l  b b����   Y S use {basic format:decimal format, minimum decimal places:1, grouping separator:""}    � �   u s e   { b a s i c   f o r m a t : d e c i m a l   f o r m a t ,   m i n i m u m   d e c i m a l   p l a c e s : 1 ,   g r o u p i n g   s e p a r a t o r : " " }  n  b j I   c j������ "0 setnumberstyle_ setNumberStyle_ �� l  c f���� n  c f o   d f���� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle m   c d��
�� misccura��  ��  ��  ��   o   b c���� 0 asocformatter asocFormatter  n  k q  I   l q��!���� 60 setminimumfractiondigits_ setMinimumFractionDigits_! "��" m   l m���� ��  ��    o   k l���� 0 asocformatter asocFormatter #$# l  r x%&'% n  r x()( I   s x��*���� 60 setmaximumfractiondigits_ setMaximumFractionDigits_* +��+ m   s t�������  ��  ) o   r s���� 0 asocformatter asocFormatter&   kludge; see note below   ' �,, .   k l u d g e ;   s e e   n o t e   b e l o w$ -.- n  y /0/ I   z ��1���� 60 setusesgroupingseparator_ setUsesGroupingSeparator_1 2��2 m   z {��
�� boovfals��  ��  0 o   y z���� 0 asocformatter asocFormatter. 3��3 l  � ���45��  4 a [ asocFormatter's setAlwaysShowsDecimalSeparator:true -- see notes in _makeNumberFormatter()   5 �66 �   a s o c F o r m a t t e r ' s   s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e   - -   s e e   n o t e s   i n   _ m a k e N u m b e r F o r m a t t e r ( )��     format real as decimal    �77 .   f o r m a t   r e a l   a s   d e c i m a l��  � l  � �89:8 k   � �;; <=< n  � �>?> I   � ���@���� "0 setnumberstyle_ setNumberStyle_@ A��A l  � �B����B n  � �CDC o   � ����� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyleD m   � ���
�� misccura��  ��  ��  ��  ? o   � ����� 0 asocformatter asocFormatter= EFE l  � ���GH��  G S M for consistency with AS, always include minimum 1DP, e.g. "1.0E8", not "1E8"   H �II �   f o r   c o n s i s t e n c y   w i t h   A S ,   a l w a y s   i n c l u d e   m i n i m u m   1 D P ,   e . g .   " 1 . 0 E 8 " ,   n o t   " 1 E 8 "F JKJ n  � �LML I   � ���N���� 60 setminimumfractiondigits_ setMinimumFractionDigits_N O��O m   � ����� ��  ��  M o   � ����� 0 asocformatter asocFormatterK PQP l  � ���RS��  R note: for some reason `setAlwaysShowsDecimalSeparator:true` is ignored, while `setMinimumFractionDigits:1` causes number to be truncated (note: maximum seems to change as well as minimum, which is wrong) unless maximum is set to a higher value afterwards (NSNumberFormatter bugs?)   S �TT2   n o t e :   f o r   s o m e   r e a s o n   ` s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e `   i s   i g n o r e d ,   w h i l e   ` s e t M i n i m u m F r a c t i o n D i g i t s : 1 `   c a u s e s   n u m b e r   t o   b e   t r u n c a t e d   ( n o t e :   m a x i m u m   s e e m s   t o   c h a n g e   a s   w e l l   a s   m i n i m u m ,   w h i c h   i s   w r o n g )   u n l e s s   m a x i m u m   i s   s e t   t o   a   h i g h e r   v a l u e   a f t e r w a r d s   ( N S N u m b e r F o r m a t t e r   b u g s ? )Q UVU n  � �WXW I   � ���Y���� 60 setmaximumfractiondigits_ setMaximumFractionDigits_Y Z��Z m   � ��������  ��  X o   � ����� 0 asocformatter asocFormatterV [��[ l  � ���\]��  \ C = asocFormatter's setAlwaysShowsDecimalSeparator:true -- ditto   ] �^^ z   a s o c F o r m a t t e r ' s   s e t A l w a y s S h o w s D e c i m a l S e p a r a t o r : t r u e   - -   d i t t o��  9    format real as scientific   : �__ 4   f o r m a t   r e a l   a s   s c i e n t i f i c� Q K formatting switches between notations depending on number's type and value   � �`` �   f o r m a t t i n g   s w i t c h e s   b e t w e e n   n o t a t i o n s   d e p e n d i n g   o n   n u m b e r ' s   t y p e   a n d   v a l u e� aba =  � �cdc o   � ����� 0 
formatname 
formatNamed m   � ���
�� MthZMth3b efe l  � �ghig n  � �jkj I   � ���l���� "0 setnumberstyle_ setNumberStyle_l m��m l  � �n����n n  � �opo o   � ����� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStylep m   � ���
�� misccura��  ��  ��  ��  k o   � ����� 0 asocformatter asocFormatterh   uses exponent notation   i �qq .   u s e s   e x p o n e n t   n o t a t i o nf rsr =  � �tut o   � ����� 0 
formatname 
formatNameu m   � ���
�� MthZMth1s vwv l  � �xyzx n  � �{|{ I   � ���}���� "0 setnumberstyle_ setNumberStyle_} ~��~ l  � ����� n  � ���� o   � ����� 40 nsnumberformatternostyle NSNumberFormatterNoStyle� m   � ���
�� misccura��  ��  ��  ��  | o   � ����� 0 asocformatter asocFormattery n h uses plain integer notation (caution: do not use for reals unless rounding to whole number is intended)   z ��� �   u s e s   p l a i n   i n t e g e r   n o t a t i o n   ( c a u t i o n :   d o   n o t   u s e   f o r   r e a l s   u n l e s s   r o u n d i n g   t o   w h o l e   n u m b e r   i s   i n t e n d e d )w ��� =  � ���� o   � ����� 0 
formatname 
formatName� m   � ���
�� MthZMth2� ��� l  � ����� n  � ���� I   � �������� "0 setnumberstyle_ setNumberStyle_� ���� l  � ������� n  � ���� o   � ����� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle� m   � ���
�� misccura��  ��  ��  ��  � o   � ����� 0 asocformatter asocFormatter� 8 2 uses thousands separators by default, no exponent   � ��� d   u s e s   t h o u s a n d s   s e p a r a t o r s   b y   d e f a u l t ,   n o   e x p o n e n t� ��� =  � ���� o   � ����� 0 
formatname 
formatName� m   � ���
�� MthZMth5� ��� l  � ����� n  � ���� I   � �������� "0 setnumberstyle_ setNumberStyle_� ���� l  � ������� n  � ���� o   � ����� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle� m   � ���
�� misccura��  ��  ��  ��  � o   � ����� 0 asocformatter asocFormatter�   adds currency symbol   � ��� *   a d d s   c u r r e n c y   s y m b o l� ��� =  � ���� o   � ����� 0 
formatname 
formatName� m   � ���
�� MthZMth4� ��� l  � ����� n  � ���� I   � �������� "0 setnumberstyle_ setNumberStyle_� ���� l  � ������� n  � ���� o   � ����� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle� m   � ���
�� misccura��  ��  ��  ��  � o   � ����� 0 asocformatter asocFormatter� ( " multiplies by 100 and appends '%'   � ��� D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % '� ��� =  ���� o   � ����� 0 
formatname 
formatName� m   ���
�� MthZMth6� ��� l ���� n ��� I  ������� "0 setnumberstyle_ setNumberStyle_� ���� l ������ n ��� o  ���� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle� m  ��
�� misccura��  ��  ��  ��  � o  ���� 0 asocformatter asocFormatter�   uses words   � ���    u s e s   w o r d s� ��� >  "��� l  ������ I  ���
� .corecnte****       ****� J  �� ��~� o  �}�} 0 
formatname 
formatName�~  � �|��{
�| 
kocl� m  �z
�z 
ctxt�{  ��  ��  � m   !�y�y  � ��x� n %+��� I  &+�w��v�w 0 
setformat_ 
setFormat_� ��u� o  &'�t�t 0 
formatname 
formatName�u  �v  � o  %&�s�s 0 asocformatter asocFormatter�x  � R  .F�r��
�r .ascrerr ****      � ****� m  BE�� ��� p i n v a l i d    b a s i c   f o r m a t    p r o p e r t y :   n o t   a n   a l l o w e d   c o n s t a n t� �q��
�q 
errn� m  25�p�p�Y� �o��
�o 
erob� o  89�n�n 0 
formatname 
formatName� �m��l
�m 
errt� m  <?�k
�k 
enum�l  � ��� l     �j�i�h�j  �i  �h  � ��� l     �g�f�e�g  �f  �e  � ��� i  : =��� I      �d��c�d  0 _nameforformat _nameForFormat� ��b� o      �a�a 0 formatstyle formatStyle�b  �c  � l    H���� Z     H����� =    ��� o     �`�` 0 formatstyle formatStyle� m    �_
�_ MthZMth1� L    �� m    �� ���  i n t e g e r� ��� =   ��� o    �^�^ 0 formatstyle formatStyle� m    �]
�] MthZMth2� ��� L    �� m    �� ���  d e c i m a l� ��� =      o    �\�\ 0 formatstyle formatStyle m    �[
�[ MthZMth5�  L     m     �  c u r r e n c y  =  ! $	
	 o   ! "�Z�Z 0 formatstyle formatStyle
 m   " #�Y
�Y MthZMth4  L   ' ) m   ' ( �  p e r c e n t  =  , / o   , -�X�X 0 formatstyle formatStyle m   - .�W
�W MthZMth3  L   2 4 m   2 3 �  s c i e n t i f i c  =  7 : o   7 8�V�V 0 formatstyle formatStyle m   8 9�U
�U MthZMth6 �T L   = ? m   = > �    w o r d�T  � L   B H!! b   B G"#" b   B E$%$ m   B C&& �''  % o   C D�S�S 0 formatstyle formatStyle# m   E F(( �))  � G A used for error reporting; formatStyle is either constant or text   � �** �   u s e d   f o r   e r r o r   r e p o r t i n g ;   f o r m a t S t y l e   i s   e i t h e r   c o n s t a n t   o r   t e x t� +,+ l     �R�Q�P�R  �Q  �P  , -.- l     �O�N�M�O  �N  �M  . /0/ l     �L12�L  1  -----   2 �33 
 - - - - -0 454 l     �K�J�I�K  �J  �I  5 676 i  > A898 I     �H:;
�H .Mth:FNumnull���     nmbr: o      �G�G 0 	thenumber 	theNumber; �F<=
�F 
Usin< |�E�D>�C?�E  �D  > o      �B�B 0 formatstyle formatStyle�C  ? l     @�A�@@ m      �?
�? MthZMth0�A  �@  = �>A�=
�> 
LocaA |�<�;B�:C�<  �;  B o      �9�9 0 
localecode 
localeCode�:  C l     D�8�7D m      EE �FF  n o n e�8  �7  �=  9 Q     dGHIG k    NJJ KLK l   "MNOM Z   "PQ�6�5P =    RSR l   T�4�3T I   �2UV
�2 .corecnte****       ****U J    WW X�1X o    �0�0 0 	thenumber 	theNumber�1  V �/Y�.
�/ 
koclY m    �-
�- 
nmbr�.  �4  �3  S m    �,�,  Q n   Z[Z I    �+\�*�+ 60 throwinvalidparametertype throwInvalidParameterType\ ]^] o    �)�) 0 	thenumber 	theNumber^ _`_ m    aa �bb  ` cdc m    �(
�( 
nmbrd e�'e m    ff �gg  n u m b e r�'  �*  [ o    �&�& 0 _support  �6  �5  N � � only accept integer or real types (i.e. allowing a text parameter to be coerced to number would defeat the purpose of these handlers, which is to avoid unintended localization behavior)   O �hht   o n l y   a c c e p t   i n t e g e r   o r   r e a l   t y p e s   ( i . e .   a l l o w i n g   a   t e x t   p a r a m e t e r   t o   b e   c o e r c e d   t o   n u m b e r   w o u l d   d e f e a t   t h e   p u r p o s e   o f   t h e s e   h a n d l e r s ,   w h i c h   i s   t o   a v o i d   u n i n t e n d e d   l o c a l i z a t i o n   b e h a v i o r )L iji r   # -klk I   # +�%m�$�% ,0 _makenumberformatter _makeNumberFormatterm non o   $ %�#�# 0 formatstyle formatStyleo pqp o   % &�"�" 0 
localecode 
localeCodeq r�!r o   & '� �  0 	thenumber 	theNumber�!  �$  l o      �� 0 asocformatter asocFormatterj sts r   . 6uvu n  . 4wxw I   / 4�y�� &0 stringfromnumber_ stringFromNumber_y z�z o   / 0�� 0 	thenumber 	theNumber�  �  x o   . /�� 0 asocformatter asocFormatterv o      �� 0 
asocstring 
asocStringt {|{ l  7 I}~} Z  7 I����� =  7 :��� o   7 8�� 0 
asocstring 
asocString� m   8 9�
� 
msng� R   = E���
� .ascrerr ****      � ****� m   C D�� ��� F I n v a l i d   n u m b e r   ( c o n v e r s i o n   f a i l e d ) .� ���
� 
errn� m   ? @���Y� ���
� 
erob� o   A B�� 0 	thenumber 	theNumber�  �  �  ~ n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure    ��� �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r e| ��� L   J N�� c   J M��� o   J K�� 0 
asocstring 
asocString� m   K L�
� 
ctxt�  H R      ���
� .ascrerr ****      � ****� o      �
�
 0 etext eText� �	��
�	 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  I I   V d���� 
0 _error  � ��� m   W Z�� ���  f o r m a t   n u m b e r� ��� o   Z [� �  0 etext eText� ��� o   [ \���� 0 enumber eNumber� ��� o   \ ]���� 0 efrom eFrom� ���� o   ] ^���� 
0 eto eTo��  �  7 ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  B E��� I     ����
�� .Mth:PNumnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� MthZMth0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      �� ���  n o n e��  ��  ��  � Q     ����� k    ��� ��� l   "���� Z   "������� =    ��� l   ������ I   ����
�� .corecnte****       ****� J    �� ���� o    ���� 0 thetext theText��  � �����
�� 
kocl� m    ��
�� 
ctxt��  ��  ��  � m    ����  � n   ��� I    ������� 60 throwinvalidparametertype throwInvalidParameterType� ��� o    ���� 0 thetext theText� ��� m    �� ���  � ��� m    ��
�� 
ctxt� ���� m    �� ���  t e x t��  ��  � o    ���� 0 _support  ��  ��  � 1 + only accept text, for same reason as above   � ��� V   o n l y   a c c e p t   t e x t ,   f o r   s a m e   r e a s o n   a s   a b o v e� ��� r   # -��� I   # +������� ,0 _makenumberformatter _makeNumberFormatter� ��� o   $ %���� 0 formatstyle formatStyle� ��� o   % &���� 0 
localecode 
localeCode� ���� m   & '��
�� 
msng��  ��  � o      ���� 0 asocformatter asocFormatter� ��� r   . 6��� n  . 4��� I   / 4������� &0 numberfromstring_ numberFromString_� ���� o   / 0���� 0 thetext theText��  ��  � o   . /���� 0 asocformatter asocFormatter� o      ���� 0 
asocnumber 
asocNumber� ��� Z   7 �������� =  7 :��� o   7 8���� 0 
asocnumber 
asocNumber� m   8 9��
�� 
msng� k   = ��� ��� r   = J��� c   = H��� n  = F��� I   B F�������� $0 localeidentifier localeIdentifier��  ��  � n  = B��� I   > B�������� 
0 locale  ��  ��  � o   = >���� 0 asocformatter asocFormatter� m   F G��
�� 
ctxt� o      ���� $0 localeidentifier localeIdentifier� ��� Z   K `� ��� =   K P n  K N 1   L N��
�� 
leng o   K L���� $0 localeidentifier localeIdentifier m   N O����    l  S V r   S V	
	 m   S T �  n o
 o      ���� $0 localeidentifier localeIdentifier #  empty string = system locale    � :   e m p t y   s t r i n g   =   s y s t e m   l o c a l e��   r   Y ` b   Y ^ b   Y \ m   Y Z � 
 t h e    o   Z [���� $0 localeidentifier localeIdentifier m   \ ] �   o      ���� $0 localeidentifier localeIdentifier� �� R   a ���
�� .ascrerr ****      � **** l  m ����� b   m � b   m } b   m { !  b   m w"#" m   m p$$ �%% R I n v a l i d   t e x t   ( e x p e c t e d   n u m e r i c a l   t e x t   i n  # I   p v��&����  0 _nameforformat _nameForFormat& '��' o   q r���� 0 formatstyle formatStyle��  ��  ! m   w z(( �))    f o r m a t   f o r   o   { |���� $0 localeidentifier localeIdentifier m   } �** �++    l o c a l e ) .��  ��   ��,-
�� 
errn, m   e h�����Y- ��.��
�� 
erob. o   k l���� 0 thetext theText��  ��  ��  ��  � /��/ L   � �00 c   � �121 o   � ����� 0 
asocnumber 
asocNumber2 m   � ���
�� 
****��  � R      ��34
�� .ascrerr ****      � ****3 o      ���� 0 etext eText4 ��56
�� 
errn5 o      ���� 0 enumber eNumber6 ��78
�� 
erob7 o      ���� 0 efrom eFrom8 ��9��
�� 
errt9 o      ���� 
0 eto eTo��  � I   � ���:���� 
0 _error  : ;<; m   � �== �>>  p a r s e   n u m b e r< ?@? o   � ����� 0 etext eText@ ABA o   � ����� 0 enumber eNumberB CDC o   � ����� 0 efrom eFromD E��E o   � ����� 
0 eto eTo��  ��  � FGF l     ��������  ��  ��  G HIH l     ��������  ��  ��  I JKJ l     ��LM��  L J D--------------------------------------------------------------------   M �NN � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -K OPO l     ��QR��  Q $  Hexadecimal number conversion   R �SS <   H e x a d e c i m a l   n u m b e r   c o n v e r s i o nP TUT l     ��������  ��  ��  U VWV i  F IXYX I     ��Z[
�� .Mth:NuHenull���     ****Z o      ���� 0 	thenumber 	theNumber[ ��\]
�� 
Plac\ |����^��_��  ��  ^ o      �� 0 	chunksize 	chunkSize��  _ l     `�~�}` m      �|�|  �~  �}  ] �{a�z
�{ 
Prefa |�y�xb�wc�y  �x  b o      �v�v 0 	hasprefix 	hasPrefix�w  c l     d�u�td m      �s
�s boovfals�u  �t  �z  Y Q    �efge k   �hh iji r    klk n   mnm I    �ro�q�r (0 asintegerparameter asIntegerParametero pqp o    	�p�p 0 	chunksize 	chunkSizeq r�or m   	 
ss �tt 
 w i d t h�o  �q  n o    �n�n 0 _support  l o      �m�m 0 	chunksize 	chunkSizej uvu l   wxyw r    z{z n   |}| I    �l~�k�l (0 asbooleanparameter asBooleanParameter~ � o    �j�j 0 	hasprefix 	hasPrefix� ��i� m    �� ���  p r e f i x�i  �k  } o    �h�h 0 _support  { o      �g�g 0 	hasprefix 	hasPrefixx � � (users shouldn't concatenate their own prefix as that would result in negative numbers appearing as "0x-N�" instead of "-0xN�")   y ���    ( u s e r s   s h o u l d n ' t   c o n c a t e n a t e   t h e i r   o w n   p r e f i x   a s   t h a t   w o u l d   r e s u l t   i n   n e g a t i v e   n u m b e r s   a p p e a r i n g   a s   " 0 x - N & "   i n s t e a d   o f   " - 0 x N & " )v ��f� Z   ����e�� =    *��� l   (��d�c� I   (�b��
�b .corecnte****       ****� J    "�� ��a� o     �`�` 0 	thenumber 	theNumber�a  � �_��^
�_ 
kocl� m   # $�]
�] 
list�^  �d  �c  � m   ( )�\�\  � l  -E���� k   -E�� ��� l  - :���� r   - :��� n  - 8��� I   2 8�[��Z�[ 00 aswholenumberparameter asWholeNumberParameter� ��� o   2 3�Y�Y 0 	thenumber 	theNumber� ��X� m   3 4�� ���  �X  �Z  � o   - 2�W�W 0 _support  � o      �V�V 0 	thenumber 	theNumber� ^ X numbers greater than 2^30 (max integer size) are okay as long as they're non-fractional   � ��� �   n u m b e r s   g r e a t e r   t h a n   2 ^ 3 0   ( m a x   i n t e g e r   s i z e )   a r e   o k a y   a s   l o n g   a s   t h e y ' r e   n o n - f r a c t i o n a l� ��� l  ; ;�U���U  � � � note that the 1024 max chunk size is somewhat arbitrary (the largest representable number requires ~309 chars; anything more will always be left-hand padding), but prevents completely silly values   � ����   n o t e   t h a t   t h e   1 0 2 4   m a x   c h u n k   s i z e   i s   s o m e w h a t   a r b i t r a r y   ( t h e   l a r g e s t   r e p r e s e n t a b l e   n u m b e r   r e q u i r e s   ~ 3 0 9   c h a r s ;   a n y t h i n g   m o r e   w i l l   a l w a y s   b e   l e f t - h a n d   p a d d i n g ) ,   b u t   p r e v e n t s   c o m p l e t e l y   s i l l y   v a l u e s� ��� Z  ; Z���T�S� G   ; F��� A   ; >��� o   ; <�R�R 0 	chunksize 	chunkSize� m   < =�Q�Q  � ?   A D��� o   A B�P�P 0 	chunksize 	chunkSize� m   B C�O�O � n  I V��� I   N V�N��M�N .0 throwinvalidparameter throwInvalidParameter� ��� o   N O�L�L 0 	chunksize 	chunkSize� ��� m   O P�� ��� 
 w i d t h� ��� m   P Q�K
�K 
long� ��J� m   Q R�� ���  m u s t   b e   0  1 0 2 4�J  �M  � o   I N�I�I 0 _support  �T  �S  � ��� r   [ `��� m   [ ^�� ���  � o      �H�H 0 hextext hexText� ��� Z   a ����G�� A   a d��� o   a b�F�F 0 	thenumber 	theNumber� m   b c�E�E  � k   g ��� ��� Z  g ����D�C� F   g v��� ?   g j��� o   g h�B�B 0 	chunksize 	chunkSize� m   h i�A�A  � l  m t��@�?� A   m t��� o   m n�>�> 0 	thenumber 	theNumber� a   n s��� m   n q�=�=��� o   q r�<�< 0 	chunksize 	chunkSize�@  �?  � n  y ���� I   ~ ��;��:�; .0 throwinvalidparameter throwInvalidParameter� ��� o   ~ �9�9 0 	thenumber 	theNumber� ��� m    ��� ���  � ��� m   � ��8
�8 
long� ��7� b   � ���� b   � ���� b   � ���� m   � ��� ��� X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  � l  � ���6�5� a   � ���� m   � ��4�4��� o   � ��3�3 0 	chunksize 	chunkSize�6  �5  � m   � ��� ��� 
   a n d  � l  � ���2�1� \   � ���� a   � ���� m   � ��0�0 � o   � ��/�/ 0 	chunksize 	chunkSize� m   � ��.�. �2  �1  �7  �:  � o   y ~�-�- 0 _support  �D  �C  � ��� r   � ���� m   � ��� �    -� o      �,�, 0 	hexprefix 	hexPrefix� �+ r   � � d   � � o   � ��*�* 0 	thenumber 	theNumber o      �)�) 0 	thenumber 	theNumber�+  �G  � k   � �  r   � �	 m   � �

 �  	 o      �(�( 0 	hexprefix 	hexPrefix �' Z  � ��&�% F   � � ?   � � o   � ��$�$ 0 	chunksize 	chunkSize m   � ��#�#   l  � ��"�! ?   � � o   � �� �  0 	thenumber 	theNumber \   � � a   � � m   � ���  o   � ��� 0 	chunksize 	chunkSize m   � ��� �"  �!   n  � � I   � ���� .0 throwinvalidparameter throwInvalidParameter  o   � ��� 0 	thenumber 	theNumber   m   � �!! �""    #$# m   � ��
� 
long$ %�% b   � �&'& b   � �()( b   � �*+* m   � �,, �-- X s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n  + l  � �.��. a   � �/0/ m   � �����0 o   � ��� 0 	chunksize 	chunkSize�  �  ) m   � �11 �22 
   a n d  ' l  � �3��3 \   � �454 a   � �676 m   � ��� 7 o   � ��� 0 	chunksize 	chunkSize5 m   � ��� �  �  �  �   o   � ��� 0 _support  �&  �%  �'  � 898 Z  � �:;��: o   � ��� 0 	hasprefix 	hasPrefix; r   � �<=< b   � �>?> o   � ��
�
 0 	hexprefix 	hexPrefix? m   � �@@ �AA  0 x= o      �	�	 0 	hexprefix 	hexPrefix�  �  9 BCB V   'DED k  "FF GHG r  IJI b  KLK l M��M n  NON 4  �P
� 
cobjP l Q��Q [  RSR `  TUT o  �� 0 	thenumber 	theNumberU m  �� S m  �� �  �  O m  VV �WW   0 1 2 3 4 5 6 7 8 9 A B C D E F�  �  L o  � �  0 hextext hexTextJ o      ���� 0 hextext hexTextH X��X r  "YZY _   [\[ o  ���� 0 	thenumber 	theNumber\ m  ���� Z o      ���� 0 	thenumber 	theNumber��  E ?  ]^] o  ���� 0 	thenumber 	theNumber^ m  ����  C _`_ V  (@aba r  4;cdc b  49efe m  47gg �hh  0f o  78���� 0 hextext hexTextd o      ���� 0 hextext hexTextb A  ,3iji n  ,1klk 1  -1��
�� 
lengl o  ,-���� 0 hextext hexTextj o  12���� 0 	chunksize 	chunkSize` m��m L  AEnn b  ADopo o  AB���� 0 	hexprefix 	hexPrefixp o  BC���� 0 hextext hexText��  �   format single number   � �qq *   f o r m a t   s i n g l e   n u m b e r�e  � l H�rstr k  H�uu vwv l Hkxyzx Z Hk{|����{ G  HS}~} A  HK� o  HI���� 0 	chunksize 	chunkSize� m  IJ���� ~ ?  NQ��� o  NO���� 0 	chunksize 	chunkSize� m  OP���� | n Vg��� I  [g������� .0 throwinvalidparameter throwInvalidParameter� ��� o  [\���� 0 	chunksize 	chunkSize� ��� m  \_�� ��� 
 w i d t h� ��� m  _`��
�� 
long� ���� m  `c�� ���  m u s t   b e   1  1 0 2 4��  ��  � o  V[���� 0 _support  ��  ��  y   chunksize must be given   z ��� 0   c h u n k s i z e   m u s t   b e   g i v e nw ��� r  l���� J  lx�� ��� m  lo�� ���  � ���� \  ov��� a  ot��� m  or���� � o  rs���� 0 	chunksize 	chunkSize� m  tu���� ��  � J      �� ��� o      ���� 0 padtext padText� ���� o      ���� 0 maxsize maxSize��  � ��� U  ����� r  ����� b  ����� o  ������ 0 padtext padText� m  ���� ���  0� o      ���� 0 padtext padText� o  ������ 0 	chunksize 	chunkSize� ��� h  ������� 0 
resultlist 
resultList� j     	����� 
0 _list_  � n    ��� 2   ��
�� 
cobj� o     ���� 0 	thenumber 	theNumber� ��� X  ������� k  �{�� ��� Q  �6���� k  ���� ��� r  ����� c  ����� n ����� 1  ����
�� 
pcnt� o  ������ 0 aref aRef� m  ����
�� 
long� o      ���� 0 	thenumber 	theNumber� ���� Z ��������� G  ����� G  ����� >  ����� o  ������ 0 	thenumber 	theNumber� c  ����� n ����� 1  ����
�� 
pcnt� o  ������ 0 aref aRef� m  ����
�� 
doub� A  ����� o  ������ 0 	thenumber 	theNumber� m  ������  � ?  ����� o  ������ 0 	thenumber 	theNumber� o  ������ 0 maxsize maxSize� R  �������
�� .ascrerr ****      � ****��  � �����
�� 
errn� m  �������\��  ��  ��  ��  � R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � Z  6������ ?  ��� o  ���� 0 	thenumber 	theNumber� o  ���� 0 maxsize maxSize� n 	"��� I  "������� .0 throwinvalidparameter throwInvalidParameter� ��� o  ���� 0 	thenumber 	theNumber� ��� m  �� ���  � ��� m  ��
�� 
long� ���� b  ��� m  �� ��� h s p e c i f i e d   w i d t h   o n l y   a l l o w s   n u m b e r s   b e t w e e n   0 . 0   a n d  � l ������ \  ��� a  ��� m  ���� � o  ���� 0 	chunksize 	chunkSize� m  ���� ��  ��  ��  ��  � o  	���� 0 _support  ��  � n %6��� I  *6������� .0 throwinvalidparameter throwInvalidParameter� ��� o  *+���� 0 aref aRef� ��� m  +.�� ���  �    m  ./��
�� 
long �� m  /2 � V e x p e c t e d   n o n - n e g a t i v e   n o n - f r a c t i o n a l   n u m b e r��  ��  � o  %*���� 0 _support  �  r  7< m  7:		 �

   o      ���� 0 hextext hexText  V  =d k  E_  r  EW b  EU l ES���� n  ES 4  HS��
�� 
cobj l KR���� [  KR `  KP o  KL���� 0 	thenumber 	theNumber m  LO����  m  PQ���� ��  ��   m  EH �     0 1 2 3 4 5 6 7 8 9 A B C D E F��  ��   o  ST���� 0 hextext hexText o      ���� 0 hextext hexText !��! r  X_"#" _  X]$%$ o  XY���� 0 	thenumber 	theNumber% m  Y\���� # o      ���� 0 	thenumber 	theNumber��   ?  AD&'& o  AB���� 0 	thenumber 	theNumber' m  BC����   (��( r  e{)*) n eu+,+ 7 hu��-.
�� 
ctxt- d  nq// o  op���� 0 	chunksize 	chunkSize. m  rt������, l eh0����0 b  eh121 o  ef���� 0 padtext padText2 o  fg���� 0 hextext hexText��  ��  * n     343 1  vz��
�� 
pcnt4 o  uv���� 0 aref aRef��  �� 0 aref aRef� n ��565 o  ������ 
0 _list_  6 o  ������ 0 
resultlist 
resultList� 787 r  ��9:9 n ��;<; 1  ����
�� 
txdl< 1  ����
�� 
ascr: o      ���� 0 oldtids oldTIDs8 =>= r  ��?@? m  ��AA �BB  @ n     CDC 1  ����
�� 
txdlD 1  ����
�� 
ascr> EFE Z  ��GH��IG o  ������ 0 	hasprefix 	hasPrefixH r  ��JKJ b  ��LML m  ��NN �OO  0 xM n ��PQP o  ������ 
0 _list_  Q o  ������ 0 
resultlist 
resultListK o      ���� 0 hextext hexText��  I r  ��RSR c  ��TUT n ��VWV o  ������ 
0 _list_  W o  ������ 0 
resultlist 
resultListU m  ���
� 
ctxtS o      �~�~ 0 hextext hexTextF XYX r  ��Z[Z o  ���}�} 0 oldtids oldTIDs[ n     \]\ 1  ���|
�| 
txdl] 1  ���{
�{ 
ascrY ^�z^ L  ��__ o  ���y�y 0 hextext hexText�z  s   format list of number   t �`` ,   f o r m a t   l i s t   o f   n u m b e r�f  f R      �xab
�x .ascrerr ****      � ****a o      �w�w 0 etext eTextb �vcd
�v 
errnc o      �u�u 0 enumber eNumberd �tef
�t 
erobe o      �s�s 0 efrom eFromf �rg�q
�r 
errtg o      �p�p 
0 eto eTo�q  g I  ���oh�n�o 
0 _error  h iji m  ��kk �ll  f o r m a t   h e xj mnm o  ���m�m 0 etext eTextn opo o  ���l�l 0 enumber eNumberp qrq o  ���k�k 0 efrom eFromr s�js o  ���i�i 
0 eto eTo�j  �n  W tut l     �h�g�f�h  �g  �f  u vwv l     �e�d�c�e  �d  �c  w xyx i  J Mz{z I     �b|}
�b .Mth:HeNunull���     ctxt| o      �a�a 0 hextext hexText} �`~
�` 
Plac~ |�_�^��]��_  �^  � o      �\�\ 0 	chunksize 	chunkSize�]  � l     ��[�Z� m      �Y�Y  �[  �Z   �X��W
�X 
Prec� |�V�U��T��V  �U  � o      �S�S 0 	isprecise 	isPrecise�T  � l     ��R�Q� m      �P
�P boovtrue�R  �Q  �W  { Q    b���� P   L���� k   K�� ��� r    ��� n   ��� I    �O��N�O "0 astextparameter asTextParameter� ��� o    �M�M 0 hextext hexText� ��L� m    �� ���  �L  �N  � o    �K�K 0 _support  � o      �J�J 0 hextext hexText� ��� r    #��� n   !��� I    !�I��H�I (0 asintegerparameter asIntegerParameter� ��� o    �G�G 0 	chunksize 	chunkSize� ��F� m    �� ��� 
 w i d t h�F  �H  � o    �E�E 0 _support  � o      �D�D 0 	chunksize 	chunkSize� ��� Z  $ C���C�B� G   $ /��� A   $ '��� o   $ %�A�A 0 	chunksize 	chunkSize� m   % &�@�@  � ?   * -��� o   * +�?�? 0 	chunksize 	chunkSize� m   + ,�>�> � n  2 ?��� I   7 ?�=��<�= .0 throwinvalidparameter throwInvalidParameter� ��� o   7 8�;�; 0 	chunksize 	chunkSize� ��� m   8 9�� ��� 
 w i d t h� ��� m   9 :�:
�: 
long� ��9� m   : ;�� ���  m u s t   b e   0  1 0 2 4�9  �<  � o   2 7�8�8 0 _support  �C  �B  � ��� r   D R��� H   D P�� n  D O��� I   I O�7��6�7 (0 asbooleanparameter asBooleanParameter� ��� o   I J�5�5 0 	isprecise 	isPrecise� ��4� m   J K�� ���  p r e c i s i o n   l o s s�4  �6  � o   D I�3�3 0 _support  � o      �2�2 0 	isprecise 	isPrecise� ��1� Z   SK���0�� =   S V��� o   S T�/�/ 0 	chunksize 	chunkSize� m   T U�.�.  � l  Y;���� k   Y;�� ��� Q   Y���� k   \ ��� ��� r   \ _��� m   \ ]�-�-  � o      �,�, 0 	thenumber 	theNumber� ��� r   ` e��� C   ` c��� o   ` a�+�+ 0 hextext hexText� m   a b�� ���  -� o      �*�* 0 
isnegative 
isNegative� ��� Z  f }���)�(� o   f g�'�' 0 
isnegative 
isNegative� r   j y��� n   j w��� 7  k w�&��
�& 
ctxt� m   q s�%�% � m   t v�$�$��� o   j k�#�# 0 hextext hexText� o      �"�" 0 hextext hexText�)  �(  � ��� Z  ~ ����!� � C   ~ ���� o   ~ �� 0 hextext hexText� m    ��� ���  0 x� r   � ���� n   � ���� 7  � ����
� 
ctxt� m   � ��� � m   � ������ o   � ��� 0 hextext hexText� o      �� 0 hextext hexText�!  �   � ��� X   � � �  k   � �  r   � � ]   � � o   � ��� 0 	thenumber 	theNumber m   � ���  o      �� 0 	thenumber 	theNumber 	
	 r   � � I  � �� z��
� .sysooffslong    ��� null
� misccura�   �
� 
psof o   � ��� 0 charref charRef ��
� 
psin m   � � �   0 1 2 3 4 5 6 7 8 9 A B C D E F�   o      �� 0 i  
  Z  � ��� =   � � o   � ��
�
 0 i   m   � ��	�	   R   � ���
� .ascrerr ****      � ****�   ��
� 
errn m   � ����@�  �  �   � r   � � \   � �  [   � �!"! o   � ��� 0 	thenumber 	theNumber" o   � ��� 0 i    m   � �� �   o      ���� 0 	thenumber 	theNumber�  � 0 charref charRef o   � ����� 0 hextext hexText�  � R      ����#
�� .ascrerr ****      � ****��  # ��$��
�� 
errn$ d      %% m      �������  � l  �&'(& R   ���)*
�� .ascrerr ****      � ****) m  ++ �,, > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .* ��-.
�� 
errn- m   � ������Y. ��/��
�� 
erob/ o  ���� 0 hextext hexText��  ' E ? catch errors if hexText is too short or contains non-hex chars   ( �00 ~   c a t c h   e r r o r s   i f   h e x T e x t   i s   t o o   s h o r t   o r   c o n t a i n s   n o n - h e x   c h a r s� 121 Z 	+34����3 F  	565 o  	
���� 0 	isprecise 	isPrecise6 l 7����7 =  898 o  ���� 0 	thenumber 	theNumber9 [  :;: o  ���� 0 	thenumber 	theNumber; m  ���� ��  ��  4 R  '��<=
�� .ascrerr ****      � ****< m  #&>> �?? � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .= ��@A
�� 
errn@ m  �����YA ��B��
�� 
erobB o  !"���� 0 hextext hexText��  ��  ��  2 CDC Z ,8EF����E o  ,-���� 0 
isnegative 
isNegativeF r  04GHG d  02II o  01���� 0 	thenumber 	theNumberH o      ���� 0 	thenumber 	theNumber��  ��  D J��J L  9;KK o  9:���� 0 	thenumber 	theNumber��  �   read as single number   � �LL ,   r e a d   a s   s i n g l e   n u m b e r�0  � l >KMNOM k  >KPP QRQ Z >dST����S >  >GUVU `  >EWXW l >CY����Y n >CZ[Z 1  ?C��
�� 
leng[ o  >?���� 0 hextext hexText��  ��  X o  CD���� 0 	chunksize 	chunkSizeV m  EF����  T R  J`��\]
�� .ascrerr ****      � ****\ b  V_^_^ b  V[`a` m  VYbb �cc T C a n ' t   s p l i t   h e x a d e c i m a l   t e x t   e x a c t l y   i n t o  a o  YZ���� 0 	chunksize 	chunkSize_ m  [^dd �ee  - d i g i t   c h u n k s .] ��fg
�� 
errnf m  NQ�����Yg ��h��
�� 
erobh o  TU���� 0 hextext hexText��  ��  ��  R iji h  ep��k�� 0 
resultlist 
resultListk j     ��l�� 
0 _list_  l J     ����  j mnm Y  qCo��pqro k  �>ss tut r  ��vwv m  ������  w o      ���� 0 	thenumber 	theNumberu xyx X  �z��{z k  ��|| }~} r  ��� ]  ����� o  ������ 0 	thenumber 	theNumber� m  ������ � o      ���� 0 	thenumber 	theNumber~ ��� r  ����� I ������� z����
�� .sysooffslong    ��� null
�� misccura��  � ����
�� 
psof� o  ������ 0 charref charRef� �����
�� 
psin� m  ���� ���   0 1 2 3 4 5 6 7 8 9 A B C D E F��  � o      ���� 0 i  � ��� Z ��������� =  ����� o  ������ 0 i  � m  ������  � R  ������
�� .ascrerr ****      � ****� m  ���� ��� > N o t   a   v a l i d   h e x a d e c i m a l   n u m b e r .� ����
�� 
errn� m  �������Y� �����
�� 
erob� l �������� N  ���� n  ����� 7 ������
�� 
ctxt� o  ������ 0 i  � l �������� \  ����� [  ����� o  ������ 0 i  � o  ������ 0 	chunksize 	chunkSize� m  ������ ��  ��  � o  ������ 0 hextext hexText��  ��  ��  ��  ��  � ���� r  ����� \  ����� [  ����� o  ������ 0 	thenumber 	theNumber� o  ������ 0 i  � m  ������ � o      ���� 0 	thenumber 	theNumber��  �� 0 charref charRef{ n ����� 7 ������
�� 
ctxt� o  ������ 0 i  � l �������� \  ����� [  ����� o  ������ 0 i  � o  ������ 0 	chunksize 	chunkSize� m  ������ ��  ��  � o  ������ 0 hextext hexTexty ��� Z 5������� F  ��� o  ���� 0 	isprecise 	isPrecise� l ������ =  ��� o  ���� 0 	thenumber 	theNumber� [  
��� o  ���� 0 	thenumber 	theNumber� m  	���� ��  ��  � R  1����
�� .ascrerr ****      � ****� m  -0�� ��� � H e x a d e c i m a l   t e x t   i s   t o o   l a r g e   t o   c o n v e r t   t o   n u m b e r   w i t h o u t   l o s i n g   p r e c i s i o n .� ����
�� 
errn� m  �����Y� �����
�� 
erob� l ,������ N  ,�� n  +��� 7 +����
�� 
ctxt� o  !#���� 0 i  � l $*������ \  $*��� [  %(��� o  %&���� 0 i  � o  &'���� 0 	chunksize 	chunkSize� m  ()���� ��  ��  � o  ���� 0 hextext hexText��  ��  ��  ��  ��  � ���� r  6>��� o  67���� 0 	thenumber 	theNumber� n      ���  ;  <=� n 7<��� o  8<���� 
0 _list_  � o  78���� 0 
resultlist 
resultList��  �� 0 i  p m  tu���� q n u{��� 1  vz��
�� 
leng� o  uv�� 0 hextext hexTextr o  {|�~�~ 0 	chunksize 	chunkSizen ��}� L  DK�� n DJ��� o  EI�|�| 
0 _list_  � o  DE�{�{ 0 
resultlist 
resultList�}  N   read as list of numbers   O ��� 0   r e a d   a s   l i s t   o f   n u m b e r s�1  � �z�
�z consdiac� �y�
�y conshyph� �x�
�x conspunc� �w�v
�w conswhit�v  � �u�
�u conscase� �t�s
�t consnume�s  � R      �r��
�r .ascrerr ****      � ****� o      �q�q 0 etext eText� �p��
�p 
errn� o      �o�o 0 enumber eNumber� �n��
�n 
erob� o      �m�m 0 efrom eFrom� �l��k
�l 
errt� o      �j�j 
0 eto eTo�k  � I  Tb�i��h�i 
0 _error  � ��� m  UX�� ���  p a r s e   h e x� ��� o  XY�g�g 0 etext eText� ��� o  YZ�f�f 0 enumber eNumber� ��� o  Z[�e�e 0 efrom eFrom� ��d� o  [\�c�c 
0 eto eTo�d  �h  y ��� l     �b�a�`�b  �a  �`  � ��� l     �_�^�]�_  �^  �]  � ��� l     �\���\  � J D--------------------------------------------------------------------   � �	 	  � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� 			 l     �[		�[  	 !  General numeric operations   	 �		 6   G e n e r a l   n u m e r i c   o p e r a t i o n s	 			 l     �Z�Y�X�Z  �Y  �X  	 				 i  N Q	
		
 I     �W	�V
�W .Mth:DeRanull���     doub	 o      �U�U 0 x  �V  	 Q     				 L    		 ]    
			 l   	�T�S	 c    			 o    �R�R 0 x  	 m    �Q
�Q 
doub�T  �S  	 l   		�P�O	 ^    				 1    �N
�N 
pi  	 m    �M�M ��P  �O  	 R      �L		
�L .ascrerr ****      � ****	 o      �K�K 0 etext eText	 �J		
�J 
errn	 o      �I�I 0 enumber eNumber	 �H		
�H 
erob	 o      �G�G 0 efrom eFrom	 �F	�E
�F 
errt	 o      �D�D 
0 eto eTo�E  	 I    �C	 �B�C 
0 _error  	  	!	"	! m    	#	# �	$	$  r a d i a n s	" 	%	&	% o    �A�A 0 etext eText	& 	'	(	' o    �@�@ 0 enumber eNumber	( 	)	*	) o    �?�? 0 efrom eFrom	* 	+�>	+ o    �=�= 
0 eto eTo�>  �B  		 	,	-	, l     �<�;�:�<  �;  �:  	- 	.	/	. l     �9�8�7�9  �8  �7  	/ 	0	1	0 i  R U	2	3	2 I     �6	4�5
�6 .Mth:RaDenull���     doub	4 o      �4�4 0 x  �5  	3 Q     	5	6	7	5 L    	8	8 ^    
	9	:	9 l   	;�3�2	; c    	<	=	< o    �1�1 0 x  	= m    �0
�0 
doub�3  �2  	: l   		>�/�.	> ^    		?	@	? 1    �-
�- 
pi  	@ m    �,�, ��/  �.  	6 R      �+	A	B
�+ .ascrerr ****      � ****	A o      �*�* 0 etext eText	B �)	C	D
�) 
errn	C o      �(�( 0 enumber eNumber	D �'	E	F
�' 
erob	E o      �&�& 0 efrom eFrom	F �%	G�$
�% 
errt	G o      �#�# 
0 eto eTo�$  	7 I    �"	H�!�" 
0 _error  	H 	I	J	I m    	K	K �	L	L  d e g r e e s	J 	M	N	M o    � �  0 etext eText	N 	O	P	O o    �� 0 enumber eNumber	P 	Q	R	Q o    �� 0 efrom eFrom	R 	S�	S o    �� 
0 eto eTo�  �!  	1 	T	U	T l     ����  �  �  	U 	V	W	V l     ����  �  �  	W 	X	Y	X l     ����  �  �  	Y 	Z	[	Z i  V Y	\	]	\ I     �	^�
� .Mth:Abs_null���     nmbr	^ o      �� 0 x  �  	] Q     )	_	`	a	_ k    	b	b 	c	d	c r    	e	f	e c    	g	h	g o    �� 0 x  	h m    �
� 
nmbr	f o      �� 0 x  	d 	i�	i Z   	 	j	k�	l	j A   	 	m	n	m o   	 
�
�
 0 x  	n m   
 �	�	  	k L    	o	o d    	p	p o    �� 0 x  �  	l L    	q	q o    �� 0 x  �  	` R      �	r	s
� .ascrerr ****      � ****	r o      �� 0 etext eText	s �	t	u
� 
errn	t o      �� 0 enumber eNumber	u �	v	w
� 
erob	v o      �� 0 efrom eFrom	w � 	x��
�  
errt	x o      ���� 
0 eto eTo��  	a I    )��	y���� 
0 _error  	y 	z	{	z m     !	|	| �	}	}  a b s	{ 	~		~ o   ! "���� 0 etext eText	 	�	�	� o   " #���� 0 enumber eNumber	� 	�	�	� o   # $���� 0 efrom eFrom	� 	���	� o   $ %���� 
0 eto eTo��  ��  	[ 	�	�	� l     ��������  ��  ��  	� 	�	�	� l     ��������  ��  ��  	� 	�	�	� i  Z ]	�	�	� I     ��	���
�� .Mth:CmpNnull���     ****	� J      	�	� 	�	�	� o      ���� 0 n1  	� 	���	� o      ���� 0 n2  ��  ��  	� Q     �	�	�	�	� k    �	�	� 	�	�	� Z    �	�	���	�	� =    	�	�	� l   	�����	� I   ��	�	�
�� .corecnte****       ****	� J    	�	� 	�	�	� o    ���� 0 n1  	� 	���	� o    ���� 0 n2  ��  	� ��	���
�� 
kocl	� m    	��
�� 
long��  ��  ��  	� m    ���� 	� Z   	�	�����	� =    	�	�	� o    ���� 0 n1  	� o    ���� 0 n2  	� L    	�	� m    ����  ��  ��  ��  	� k   ! �	�	� 	�	�	� r   ! 8	�	�	� J   ! )	�	� 	�	�	� c   ! $	�	�	� o   ! "���� 0 n1  	� m   " #��
�� 
doub	� 	���	� c   $ '	�	�	� o   $ %���� 0 n2  	� m   % &��
�� 
doub��  	� J      	�	� 	�	�	� o      ���� 0 n1  	� 	���	� o      ���� 0 n2  ��  	� 	�	�	� Z   9 T	�	���	�	� =   9 <	�	�	� o   9 :���� 0 n1  	� m   : ;����  	� r   ? H	�	�	� ]   ? F	�	�	� o   ? D���� 0 _isequaldelta _isEqualDelta	� o   D E���� 0 n2  	� o      ���� 0 dn  ��  	� r   K T	�	�	� ]   K R	�	�	� o   K P���� 0 _isequaldelta _isEqualDelta	� o   P Q���� 0 n1  	� o      ���� 0 dn  	� 	�	�	� r   U Y	�	�	� d   U W	�	� o   U V���� 0 dn  	� o      ���� 0 dm  	� 	�	�	� Z  Z w	�	�����	� ?   Z ]	�	�	� o   Z [���� 0 dm  	� o   [ \���� 0 dn  	� r   ` s	�	�	� J   ` d	�	� 	�	�	� o   ` a���� 0 dm  	� 	���	� o   a b���� 0 dn  ��  	� J      	�	� 	�	�	� o      ���� 0 dn  	� 	���	� o      ���� 0 dm  ��  ��  ��  	� 	�	�	� r   x }	�	�	� \   x {	�	�	� o   x y���� 0 n2  	� o   y z���� 0 n1  	� o      ���� 0 d  	� 	���	� Z  ~ �	�	�����	� F   ~ �	�	�	� ?   ~ �	�	�	� o   ~ ���� 0 d  	� o    ����� 0 dm  	� A   � �	�	�	� o   � ����� 0 d  	� o   � ����� 0 dn  	� L   � �	�	� m   � �����  ��  ��  ��  	� 	���	� Z   � �	�	���	�	� A   � �	�	�	� o   � ����� 0 n1  	� o   � ����� 0 n2  	� L   � �	�	� m   � ���������  	� L   � �	�	� m   � ����� ��  	� R      ��	�	�
�� .ascrerr ****      � ****	� o      ���� 0 etext eText	� ��	�	�
�� 
errn	� o      ���� 0 enumber eNumber	� ��	�	�
�� 
erob	� o      ���� 0 efrom eFrom	� ��	���
�� 
errt	� o      ���� 
0 eto eTo��  	� I   � ���	����� 
0 _error  	� 	�
 	� m   � �

 �

  c m p
  


 o   � ����� 0 etext eText
 


 o   � ����� 0 enumber eNumber
 


 o   � ����� 0 efrom eFrom
 
	��
	 o   � ����� 
0 eto eTo��  ��  	� 




 l     ��������  ��  ��  
 


 l     ��������  ��  ��  
 


 i  ^ a


 I     ��
��
�� .Mth:MinNnull���     ****
 o      ���� 0 thelist theList��  
 Q     W



 k    E

 


 h    
��
�� 0 
listobject 
listObject
 j     ��
�� 
0 _list_  
 n    


 I    ��
���� "0 aslistparameter asListParameter
 
��
 o    
���� 0 thelist theList��  ��  
 o     ���� 0 _support  
 

 
 l   
!
"
#
! r    
$
%
$ c    
&
'
& l   
(����
( n    
)
*
) 4   ��
+
�� 
cobj
+ m    ���� 
* n   
,
-
, o    ���� 
0 _list_  
- o    ���� 0 
listobject 
listObject��  ��  
' m    ��
�� 
nmbr
% o      ���� 0 	theresult 	theResult
" #  error -1728 if list is empty   
# �
.
. :   e r r o r   - 1 7 2 8   i f   l i s t   i s   e m p t y
  
/
0
/ X    B
1��
2
1 k   ( =
3
3 
4
5
4 l  ( /
6
7
8
6 r   ( /
9
:
9 c   ( -
;
<
; n  ( +
=
>
= 1   ) +��
�� 
pcnt
> o   ( )���� 0 aref aRef
< m   + ,��
�� 
nmbr
: o      ���� 0 x  
7 > 8 error -1700 if item isn't (or can't coerce to) a number   
8 �
?
? p   e r r o r   - 1 7 0 0   i f   i t e m   i s n ' t   ( o r   c a n ' t   c o e r c e   t o )   a   n u m b e r
5 
@��
@ Z  0 =
A
B��~
A A   0 3
C
D
C o   0 1�}�} 0 x  
D o   1 2�|�| 0 	theresult 	theResult
B r   6 9
E
F
E o   6 7�{�{ 0 x  
F o      �z�z 0 	theresult 	theResult�  �~  ��  �� 0 aref aRef
2 n   
G
H
G o    �y�y 
0 _list_  
H o    �x�x 0 
listobject 
listObject
0 
I�w
I L   C E
J
J o   C D�v�v 0 	theresult 	theResult�w  
 R      �u
K
L
�u .ascrerr ****      � ****
K o      �t�t 0 etext eText
L �s
M
N
�s 
errn
M o      �r�r 0 enumber eNumber
N �q
O
P
�q 
erob
O o      �p�p 0 efrom eFrom
P �o
Q�n
�o 
errt
Q o      �m�m 
0 eto eTo�n  
 I   M W�l
R�k�l 
0 _error  
R 
S
T
S m   N O
U
U �
V
V  m i n
T 
W
X
W o   O P�j�j 0 etext eText
X 
Y
Z
Y o   P Q�i�i 0 enumber eNumber
Z 
[
\
[ o   Q R�h�h 0 efrom eFrom
\ 
]�g
] o   R S�f�f 
0 eto eTo�g  �k  
 
^
_
^ l     �e�d�c�e  �d  �c  
_ 
`
a
` l     �b�a�`�b  �a  �`  
a 
b
c
b i  b e
d
e
d I     �_
f�^
�_ .Mth:MaxNnull���     ****
f o      �]�] 0 thelist theList�^  
e Q     W
g
h
i
g k    E
j
j 
k
l
k h    
�\
m�\ 0 
listobject 
listObject
m j     �[
n�[ 
0 _list_  
n n    
o
p
o I    �Z
q�Y�Z "0 aslistparameter asListParameter
q 
r�X
r o    
�W�W 0 thelist theList�X  �Y  
p o     �V�V 0 _support  
l 
s
t
s l   
u
v
w
u r    
x
y
x c    
z
{
z l   
|�U�T
| n    
}
~
} 4   �S

�S 
cobj
 m    �R�R 
~ n   
�
�
� o    �Q�Q 
0 _list_  
� o    �P�P 0 
listobject 
listObject�U  �T  
{ m    �O
�O 
nmbr
y o      �N�N 0 	theresult 	theResult
v   ditto   
w �
�
�    d i t t o
t 
�
�
� X    B
��M
�
� k   ( =
�
� 
�
�
� l  ( /
�
�
�
� r   ( /
�
�
� c   ( -
�
�
� n  ( +
�
�
� 1   ) +�L
�L 
pcnt
� o   ( )�K�K 0 aref aRef
� m   + ,�J
�J 
nmbr
� o      �I�I 0 x  
�   ditto   
� �
�
�    d i t t o
� 
��H
� Z  0 =
�
��G�F
� ?   0 3
�
�
� o   0 1�E�E 0 x  
� o   1 2�D�D 0 	theresult 	theResult
� r   6 9
�
�
� o   6 7�C�C 0 x  
� o      �B�B 0 	theresult 	theResult�G  �F  �H  �M 0 aref aRef
� n   
�
�
� o    �A�A 
0 _list_  
� o    �@�@ 0 
listobject 
listObject
� 
��?
� L   C E
�
� o   C D�>�> 0 	theresult 	theResult�?  
h R      �=
�
�
�= .ascrerr ****      � ****
� o      �<�< 0 etext eText
� �;
�
�
�; 
errn
� o      �:�: 0 enumber eNumber
� �9
�
�
�9 
erob
� o      �8�8 0 efrom eFrom
� �7
��6
�7 
errt
� o      �5�5 
0 eto eTo�6  
i I   M W�4
��3�4 
0 _error  
� 
�
�
� m   N O
�
� �
�
�  m a x
� 
�
�
� o   O P�2�2 0 etext eText
� 
�
�
� o   P Q�1�1 0 enumber eNumber
� 
�
�
� o   Q R�0�0 0 efrom eFrom
� 
��/
� o   R S�.�. 
0 eto eTo�/  �3  
c 
�
�
� l     �-�,�+�-  �,  �+  
� 
�
�
� l     �*�)�(�*  �)  �(  
� 
�
�
� i  f i
�
�
� I     �'
�
�
�' .Mth:RouNnull���     nmbr
� o      �&�& 0 num  
� �%
�
�
�% 
Plac
� |�$�#
��"
��$  �#  
� o      �!�! 0 decimalplaces decimalPlaces�"  
� l     
�� �
� m      ��  �   �  
� �
��
� 
Dire
� |��
��
��  �  
� o      �� &0 roundingdirection roundingDirection�  
� l     
���
� m      �
� MRndRNhE�  �  �  
� Q    �
�
�
�
� k   �
�
� 
�
�
� r    
�
�
� n   
�
�
� I    �
��� "0 asrealparameter asRealParameter
� 
�
�
� o    	�� 0 num  
� 
��
� m   	 

�
� �
�
�  �  �  
� o    �� 0 _support  
� o      �� 0 num  
� 
�
�
� r    
�
�
� n   
�
�
� I    �
��� (0 asintegerparameter asIntegerParameter
� 
�
�
� o    �� 0 decimalplaces decimalPlaces
� 
��
� m    
�
� �
�
�  t o   p l a c e s�  �  
� o    �
�
 0 _support  
� o      �	�	 0 decimalplaces decimalPlaces
� 
�
�
� Z    8
�
���
� >    "
�
�
� o     �� 0 decimalplaces decimalPlaces
� m     !��  
� k   % 4
�
� 
�
�
� r   % *
�
�
� a   % (
�
�
� m   % &�� 

� o   & '�� 0 decimalplaces decimalPlaces
� o      �� 0 themultiplier theMultiplier
� 
��
� l  + 4
�
�
�
� r   + 4
�
�
� ^   + 2
�
�
� ]   + 0
�
�
� ]   + .
�
�
� o   + ,� �  0 num  
� m   , -���� 

� o   . /���� 0 themultiplier theMultiplier
� m   0 1���� 

� o      ���� 0 num  
��� multiplying and dividing by 10 before and after applying the multiplier helps avoid poor rounding results for some numbers due to inevitable loss of precision in floating-point math (e.g. `324.21 * 100 div 1 / 100` returns 324.2 but needs to be 324.21), though this hasn't been tested on all possible values for obvious reasons -- TO DO: shouldn't /10 be done after rounding is applied (in which case following calculations should use mod 10, etc)?   
� �
�
��   m u l t i p l y i n g   a n d   d i v i d i n g   b y   1 0   b e f o r e   a n d   a f t e r   a p p l y i n g   t h e   m u l t i p l i e r   h e l p s   a v o i d   p o o r   r o u n d i n g   r e s u l t s   f o r   s o m e   n u m b e r s   d u e   t o   i n e v i t a b l e   l o s s   o f   p r e c i s i o n   i n   f l o a t i n g - p o i n t   m a t h   ( e . g .   ` 3 2 4 . 2 1   *   1 0 0   d i v   1   /   1 0 0 `   r e t u r n s   3 2 4 . 2   b u t   n e e d s   t o   b e   3 2 4 . 2 1 ) ,   t h o u g h   t h i s   h a s n ' t   b e e n   t e s t e d   o n   a l l   p o s s i b l e   v a l u e s   f o r   o b v i o u s   r e a s o n s   - -   T O   D O :   s h o u l d n ' t   / 1 0   b e   d o n e   a f t e r   r o u n d i n g   i s   a p p l i e d   ( i n   w h i c h   c a s e   f o l l o w i n g   c a l c u l a t i o n s   s h o u l d   u s e   m o d   1 0 ,   e t c ) ?�  �  �  
� 
�
�
� Z   9�
�
�
� 
� =  9 < o   9 :���� &0 roundingdirection roundingDirection l  : ;���� m   : ;��
�� MRndRNhE��  ��  
� Z   ? m E  ? K	 J   ? C

  m   ? @ ��       �� m   @ A ?�      ��  	 J   C J �� `   C H l  C F���� ^   C F o   C D���� 0 num   m   D E���� ��  ��   m   F G���� ��   l  N S r   N S _   N Q o   N O���� 0 num   m   O P����  o      ���� 0 num   T N if num ends in .5 and its div is even then round toward zero so it stays even    � �   i f   n u m   e n d s   i n   . 5   a n d   i t s   d i v   i s   e v e n   t h e n   r o u n d   t o w a r d   z e r o   s o   i t   s t a y s   e v e n   ?   V Y!"! o   V W���� 0 num  " m   W X����    #��# l  \ c$%&$ r   \ c'(' _   \ a)*) l  \ _+����+ [   \ _,-, o   \ ]���� 0 num  - m   ] ^.. ?�      ��  ��  * m   _ `���� ( o      ���� 0 num  % H B else round to nearest whole digit (.5 will round up if positive�)   & �// �   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t   ( . 5   w i l l   r o u n d   u p   i f   p o s i t i v e & )��   l  f m0120 r   f m343 _   f k565 l  f i7����7 \   f i898 o   f g���� 0 num  9 m   g h:: ?�      ��  ��  6 m   i j���� 4 o      ���� 0 num  1 4 . (�or down if negative to give an even result)   2 �;; \   ( & o r   d o w n   i f   n e g a t i v e   t o   g i v e   a n   e v e n   r e s u l t )
� <=< =  p s>?> o   p q���� &0 roundingdirection roundingDirection? l  q r@����@ m   q r��
�� MRndRNhT��  ��  = ABA Z   v �CDEFC E  v �GHG J   v zII JKJ m   v wLL ��      K M��M m   w xNN ?�      ��  H J   z OO P��P `   z }QRQ o   z {���� 0 num  R m   { |���� ��  D l  � �STUS r   � �VWV _   � �XYX o   � ����� 0 num  Y m   � ����� W o      ���� 0 num  T 0 * if num ends in .5 then round towards zero   U �ZZ T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r oE [\[ ?   � �]^] o   � ����� 0 num  ^ m   � �����  \ _��_ l  � �`ab` r   � �cdc _   � �efe l  � �g����g [   � �hih o   � ����� 0 num  i m   � �jj ?�      ��  ��  f m   � ����� d o      ���� 0 num  a ( " else round to nearest whole digit   b �kk D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  F r   � �lml _   � �non l  � �p����p \   � �qrq o   � ����� 0 num  r m   � �ss ?�      ��  ��  o m   � ����� m o      ���� 0 num  B tut =  � �vwv o   � ����� &0 roundingdirection roundingDirectionw l  � �x����x m   � ���
�� MRndRNhF��  ��  u yzy Z   � �{|}~{ E  � �� J   � ��� ��� m   � ��� ��      � ���� m   � ��� ?�      ��  � J   � ��� ���� `   � ���� o   � ����� 0 num  � m   � ����� ��  | l  � ����� Z   � ������� ?   � ���� o   � ����� 0 num  � m   � �����  � r   � ���� [   � ���� _   � ���� o   � ����� 0 num  � m   � ����� � m   � ����� � o      ���� 0 num  ��  � r   � ���� \   � ���� _   � ���� o   � ����� 0 num  � m   � ����� � m   � ����� � o      ���� 0 num  � 0 * if num ends in .5 then round towards zero   � ��� T   i f   n u m   e n d s   i n   . 5   t h e n   r o u n d   t o w a r d s   z e r o} ��� ?   � ���� o   � ����� 0 num  � m   � �����  � ���� l  � ����� r   � ���� _   � ���� l  � ������� [   � ���� o   � ����� 0 num  � m   � ��� ?�      ��  ��  � m   � ����� � o      ���� 0 num  � ( " else round to nearest whole digit   � ��� D   e l s e   r o u n d   t o   n e a r e s t   w h o l e   d i g i t��  ~ r   � ���� _   � ���� l  � ������� \   � ���� o   � ����� 0 num  � m   � ��� ?�      ��  ��  � m   � ����� � o      ���� 0 num  z ��� =  � ���� o   � ����� &0 roundingdirection roundingDirection� l  � ������� m   � ���
�� MRndRN_T��  ��  � ��� r   � ���� _   � ���� o   � ����� 0 num  � m   � ����� � o      ���� 0 num  � ��� =  � ���� o   � ����� &0 roundingdirection roundingDirection� l  � ������� m   � ���
�� MRndRN_F��  ��  � ��� Z   '����� =   ��� `   ��� o   ���� 0 num  � m  ���� � m  ����  � r  ��� _  ��� o  	���� 0 num  � m  	
���� � o      ���� 0 num  � ��� ?  ��� o  ���� 0 num  � m  ����  � ���� r  ��� [  ��� _  ��� o  ���� 0 num  � m  ���� � m  ���� � o      ���� 0 num  ��  � r   '��� \   %��� _   #��� o   !���� 0 num  � m  !"���� � m  #$���� � o      ���� 0 num  � ��� = *-��� o  *+���� &0 roundingdirection roundingDirection� l +,������ m  +,��
�� MRndRN_U��  ��  � ��� l 0O���� Z  0O������ G  0=��� A  03��� o  01���� 0 num  � m  12����  � =  6;��� `  69��� o  67���� 0 num  � m  78���� � m  9:����  � r  @E��� _  @C� � o  @A���� 0 num    m  AB���� � o      ���� 0 num  ��  � r  HO [  HM _  HK o  HI�� 0 num   m  IJ�~�~  m  KL�}�}  o      �|�| 0 num  �   ceil()   � �    c e i l ( )� 	 = RW

 o  RS�{�{ &0 roundingdirection roundingDirection l SV�z�y m  SV�x
�x MRndRN_D�z  �y  	 �w l Zy Z  Zy�v G  Zg ?  Z] o  Z[�u�u 0 num   m  [\�t�t   =  `e `  `c o  `a�s�s 0 num   m  ab�r�r  m  cd�q�q   r  jo _  jm o  jk�p�p 0 num   m  kl�o�o  o      �n�n 0 num  �v   r  ry !  \  rw"#" _  ru$%$ o  rs�m�m 0 num  % m  st�l�l # m  uv�k�k ! o      �j�j 0 num     floor()    �&&    f l o o r ( )�w    n |�'(' I  ���i)�h�i >0 throwinvalidconstantparameter throwInvalidConstantParameter) *+* o  ���g�g &0 roundingdirection roundingDirection+ ,�f, m  ��-- �..  b y�f  �h  ( o  |��e�e 0 _support  
� /�d/ Z  ��01230 =  ��454 o  ���c�c 0 decimalplaces decimalPlaces5 m  ���b�b  1 L  ��66 _  ��787 o  ���a�a 0 num  8 m  ���`�` 2 9:9 A  ��;<; o  ���_�_ 0 decimalplaces decimalPlaces< m  ���^�^  : =�]= L  ��>> _  ��?@? o  ���\�\ 0 num  @ o  ���[�[ 0 themultiplier theMultiplier�]  3 L  ��AA ^  ��BCB o  ���Z�Z 0 num  C o  ���Y�Y 0 themultiplier theMultiplier�d  
� R      �XDE
�X .ascrerr ****      � ****D o      �W�W 0 etext eTextE �VFG
�V 
errnF o      �U�U 0 enumber eNumberG �THI
�T 
erobH o      �S�S 0 efrom eFromI �RJ�Q
�R 
errtJ o      �P�P 
0 eto eTo�Q  
� I  ���OK�N�O 
0 _error  K LML m  ��NN �OO  r o u n d   n u m b e rM PQP o  ���M�M 0 etext eTextQ RSR o  ���L�L 0 enumber eNumberS TUT o  ���K�K 0 efrom eFromU V�JV o  ���I�I 
0 eto eTo�J  �N  
� WXW l     �H�G�F�H  �G  �F  X YZY l     �E�D�C�E  �D  �C  Z [\[ l     �B]^�B  ] J D--------------------------------------------------------------------   ^ �__ � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -\ `a` l     �Abc�A  b   Trigonometry   c �dd    T r i g o n o m e t r ya efe l     �@�?�>�@  �?  �>  f ghg i  j miji I      �=k�<�= 0 _sin  k l�;l o      �:�: 0 x  �;  �<  j k     �mm non l    	pqrp r     	sts ]     uvu l    w�9�8w `     xyx o     �7�7 0 x  y m    �6�6h�9  �8  v l   z�5�4z ^    {|{ 1    �3
�3 
pi  | m    �2�2 ��5  �4  t o      �1�1 0 x  q &   convert from degrees to radians   r �}} @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n so ~~ r   
 ��� A   
 ��� o   
 �0�0 0 x  � m    �/�/  � o      �.�. 0 isneg isNeg ��� Z   ���-�,� o    �+�+ 0 isneg isNeg� r    ��� d    �� o    �*�* 0 x  � o      �)�) 0 x  �-  �,  � ��� r    &��� _    $��� l   "��(�'� ]    "��� o    �&�& 0 x  � l   !��%�$� ^    !��� m    �#�# � 1     �"
�" 
pi  �%  �$  �(  �'  � m   " #�!�! � o      � �  0 y  � ��� r   ' 2��� \   ' 0��� o   ' (�� 0 y  � ]   ( /��� l  ( -���� _   ( -��� ]   ( +��� o   ( )�� 0 y  � m   ) *�� ?�      � m   + ,�� �  �  � m   - .�� � o      �� 0 z  � ��� Z   3 J����� =  3 8��� `   3 6��� o   3 4�� 0 z  � m   4 5�� � m   6 7�� � k   ; F�� ��� r   ; @��� [   ; >��� o   ; <�� 0 z  � m   < =�� � o      �� 0 z  � ��� r   A F��� [   A D��� o   A B�� 0 y  � m   B C�� � o      �� 0 y  �  �  �  � ��� r   K P��� `   K N��� o   K L�� 0 z  � m   L M�� � o      �
�
 0 z  � ��� Z   Q e���	�� ?   Q T��� o   Q R�� 0 z  � m   R S�� � k   W a�� ��� r   W [��� H   W Y�� o   W X�� 0 isneg isNeg� o      �� 0 isneg isNeg� ��� r   \ a��� \   \ _��� o   \ ]�� 0 z  � m   ] ^�� � o      � �  0 z  �  �	  �  � ��� r   f u��� \   f s��� l  f o������ \   f o��� l  f k������ \   f k��� o   f g���� 0 x  � ]   g j��� o   g h���� 0 y  � m   h i�� ?�!�?��v��  ��  � ]   k n��� o   k l���� 0 y  � m   l m�� >dD,���J��  ��  � ]   o r��� o   o p���� 0 y  � m   p q�� <�F���P�� o      ���� 0 z2  � ��� r   v {��� ]   v y��� o   v w���� 0 z2  � o   w x���� 0 z2  � o      ���� 0 zz  � ��� Z   | ������� G   | ���� =  | ��� o   | }���� 0 z  � m   } ~���� � =  � ���� o   � ����� 0 z  � m   � ����� � r   � ���� [   � ���� \   � ���� m   � ��� ?�      � ^   � ���� o   � ����� 0 zz  � m   � ����� � ]   � �� � ]   � � o   � ����� 0 zz   o   � ����� 0 zz    l  � ����� [   � � ]   � � l  � ����� \   � �	
	 ]   � � l  � ����� [   � � ]   � � l  � ����� \   � � ]   � � l  � ����� [   � � ]   � � m   � � ���I��� o   � ����� 0 zz   m   � � >!�{N>���  ��   o   � ����� 0 zz   m   � � >�~O~�K���  ��   o   � ����� 0 zz   m   � � >���D���  ��   o   � ����� 0 zz  
 m   � �   ?V�l�=���  ��   o   � ����� 0 zz   m   � �!! ?�UUUV���  ��  � o      ���� 0 y  ��  � r   � �"#" [   � �$%$ o   � ����� 0 z2  % ]   � �&'& ]   � �()( o   � ����� 0 z2  ) o   � ����� 0 zz  ' l  � �*����* \   � �+,+ ]   � �-.- l  � �/����/ [   � �010 ]   � �232 l  � �4����4 \   � �565 ]   � �787 l  � �9����9 [   � �:;: ]   � �<=< l  � �>����> \   � �?@? ]   � �ABA m   � �CC =���ќ�B o   � ����� 0 zz  @ m   � �DD >Z��)[��  ��  = o   � ����� 0 zz  ; m   � �EE >��V}H���  ��  8 o   � ����� 0 zz  6 m   � �FF ?*������  ��  3 o   � ����� 0 zz  1 m   � �GG ?�"w��  ��  . o   � ����� 0 zz  , m   � �HH ?�UUUU�?��  ��  # o      ���� 0 y  � IJI Z  � �KL����K o   � ����� 0 isneg isNegL r   � �MNM d   � �OO o   � ����� 0 y  N o      ���� 0 y  ��  ��  J P��P L   � �QQ o   � ����� 0 y  ��  h RSR l     ��������  ��  ��  S TUT l     ��������  ��  ��  U VWV l     ��������  ��  ��  W XYX i  n qZ[Z I     ��\��
�� .Mth:Sin_null���     doub\ o      ���� 0 x  ��  [ Q     ]^_] L    `` I    ��a���� 0 _sin  a b��b c    cdc o    ���� 0 x  d m    ��
�� 
nmbr��  ��  ^ R      ��ef
�� .ascrerr ****      � ****e o      ���� 0 etext eTextf ��gh
�� 
errng o      ���� 0 enumber eNumberh ��ij
�� 
erobi o      ���� 0 efrom eFromj ��k��
�� 
errtk o      ���� 
0 eto eTo��  _ I    ��l���� 
0 _error  l mnm m    oo �pp  s i nn qrq o    ���� 0 etext eTextr sts o    ���� 0 enumber eNumbert uvu o    ���� 0 efrom eFromv w��w o    ���� 
0 eto eTo��  ��  Y xyx l     ��������  ��  ��  y z{z l     ��������  ��  ��  { |}| i  r u~~ I     �����
�� .Mth:Cos_null���     doub� o      ���� 0 x  ��   Q      ���� L    �� I    ������� 0 _sin  � ���� [    	��� l   ������ c    ��� o    ���� 0 x  � m    ��
�� 
nmbr��  ��  � m    ���� Z��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I     ������� 
0 _error  � ��� m    �� ���  c o s� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o    �� 
0 eto eTo��  ��  } ��� l     �~�}�|�~  �}  �|  � ��� l     �{�z�y�{  �z  �y  � ��� i  v y��� I     �x��w
�x .Mth:Tan_null���     doub� o      �v�v 0 x  �w  � k    �� ��� l     �u���u  � a [ note: this starts to lose accuracy between 89.9999999 and 90�, but should be 'good enough'   � ��� �   n o t e :   t h i s   s t a r t s   t o   l o s e   a c c u r a c y   b e t w e e n   8 9 . 9 9 9 9 9 9 9   a n d   9 0 � ,   b u t   s h o u l d   b e   ' g o o d   e n o u g h '� ��t� Q    ���� k    ��� ��� r    ��� c    ��� o    �s�s 0 x  � m    �r
�r 
nmbr� o      �q�q 0 x  � ��� l  	 #���� Z  	 #���p�o� G   	 ��� =  	 ��� o   	 
�n�n 0 x  � m   
 �m�m Z� =   ��� o    �l�l 0 x  � m    �k�k� R    �j��
�j .ascrerr ****      � ****� m    �� ��� F I n v a l i d   n u m b e r   ( r e s u l t   w o u l d   b e  " ) .� �i��
�i 
errn� m    �h�h�s� �g��f
�g 
erob� o    �e�e 0 x  �f  �p  �o  � 4 . -2701 normally indicates divide-by-zero error   � ��� \   - 2 7 0 1   n o r m a l l y   i n d i c a t e s   d i v i d e - b y - z e r o   e r r o r� ��� l  $ -���� r   $ -��� ]   $ +��� l  $ '��d�c� `   $ '��� o   $ %�b�b 0 x  � m   % &�a�ah�d  �c  � l  ' *��`�_� ^   ' *��� 1   ' (�^
�^ 
pi  � m   ( )�]�] ��`  �_  � o      �\�\ 0 x  � &   convert from degrees to radians   � ��� @   c o n v e r t   f r o m   d e g r e e s   t o   r a d i a n s� ��� r   . 3��� A   . 1��� o   . /�[�[ 0 x  � m   / 0�Z�Z  � o      �Y�Y 0 isneg isNeg� ��� Z  4 @���X�W� o   4 5�V�V 0 isneg isNeg� r   8 <��� d   8 :�� o   8 9�U�U 0 x  � o      �T�T 0 x  �X  �W  � ��� r   A J��� _   A H��� l  A F��S�R� ^   A F��� o   A B�Q�Q 0 x  � l  B E��P�O� ^   B E��� 1   B C�N
�N 
pi  � m   C D�M�M �P  �O  �S  �R  � m   F G�L�L � o      �K�K 0 y  � ��� r   K V��� \   K T��� o   K L�J�J 0 y  � ]   L S��� l  L Q��I�H� _   L Q   ]   L O o   L M�G�G 0 y   m   M N ?�       m   O P�F�F �I  �H  � m   Q R�E�E � o      �D�D 0 z  �  Z   W n�C�B =  W \	
	 `   W Z o   W X�A�A 0 z   m   X Y�@�@ 
 m   Z [�?�?  k   _ j  r   _ d [   _ b o   _ `�>�> 0 z   m   ` a�=�=  o      �<�< 0 z   �; r   e j [   e h o   e f�:�: 0 y   m   f g�9�9  o      �8�8 0 y  �;  �C  �B    r   o � \   o ~ l  o x�7�6 \   o x !  l  o t"�5�4" \   o t#$# o   o p�3�3 0 x  $ ]   p s%&% o   p q�2�2 0 y  & m   q r'' ?�!�P M�5  �4  ! ]   t w()( o   t u�1�1 0 y  ) m   u v** >A�`  �7  �6   ]   x }+,+ o   x y�0�0 0 y  , m   y |-- <��&3\ o      �/�/ 0 z2   ./. r   � �010 ]   � �232 o   � ��.�. 0 z2  3 o   � ��-�- 0 z2  1 o      �,�, 0 zz  / 454 Z   � �67�+86 ?   � �9:9 o   � ��*�* 0 zz  : m   � �;; =����+�7 r   � �<=< [   � �>?> o   � ��)�) 0 z2  ? ^   � �@A@ ]   � �BCB ]   � �DED o   � ��(�( 0 z2  E o   � ��'�' 0 zz  C l  � �F�&�%F \   � �GHG ]   � �IJI l  � �K�$�#K [   � �LML ]   � �NON m   � �PP �ɒ��O?DO o   � ��"�" 0 zz  M m   � �QQ A1������$  �#  J o   � ��!�! 0 zz  H m   � �RR Aq��)�y�&  �%  A l  � �S� �S \   � �TUT ]   � �VWV l  � �X��X [   � �YZY ]   � �[\[ l  � �]��] \   � �^_^ ]   � �`a` l  � �b��b [   � �cdc o   � ��� 0 zz  d m   � �ee @ʸ��et�  �  a o   � ��� 0 zz  _ m   � �ff A4'�X*���  �  \ o   � ��� 0 zz  Z m   � �gg Awُ�����  �  W o   � ��� 0 zz  U m   � �hh A���<�Z6�   �  = o      �� 0 y  �+  8 r   � �iji o   � ��� 0 z2  j o      �� 0 y  5 klk Z  � �mn��m G   � �opo =  � �qrq o   � ��� 0 z  r m   � ��� p =  � �sts o   � ��� 0 z  t m   � ��� n r   � �uvu ^   � �wxw m   � �����x o   � ��
�
 0 y  v o      �	�	 0 y  �  �  l yzy Z  � �{|��{ o   � ��� 0 isneg isNeg| r   � �}~} d   � � o   � ��� 0 y  ~ o      �� 0 y  �  �  z ��� L   � ��� o   � ��� 0 y  �  � R      ���
� .ascrerr ****      � ****� o      � �  0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   �������� 
0 _error  � ��� m   � ��� ���  t a n� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  �t  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ������  �   inverse   � ���    i n v e r s e� ��� l     ��������  ��  ��  � ��� i  z }��� I      ������� 	0 _asin  � ���� o      ���� 0 x  ��  ��  � k     ��� ��� r     ��� A     ��� o     ���� 0 x  � m    ����  � o      ���� 0 isneg isNeg� ��� Z   ������� o    ���� 0 isneg isNeg� r   
 ��� d   
 �� o   
 ���� 0 x  � o      ���� 0 x  ��  ��  � ��� Z   %������� ?    ��� o    ���� 0 x  � m    ���� � R    !����
�� .ascrerr ****      � ****� m     �� ��� T I n v a l i d   n u m b e r   ( n o t   b e t w e e n   - 1 . 0   a n d   1 . 0 ) .� ����
�� 
errn� m    �����Y� �����
�� 
erob� o    ���� 0 x  ��  ��  ��  � ��� Z   & ������ ?   & )��� o   & '���� 0 x  � m   ' (�� ?�      � k   , �� ��� r   , 1��� \   , /��� m   , -���� � o   - .���� 0 x  � o      ���� 0 zz  � ��� r   2 W��� ^   2 U��� ]   2 E��� o   2 3���� 0 zz  � l  3 D������ [   3 D��� ]   3 B��� l  3 @������ \   3 @��� ]   3 >��� l  3 <������ [   3 <��� ]   3 :��� l  3 8������ \   3 8��� ]   3 6��� m   3 4�� ?hOØ��� o   4 5���� 0 zz  � m   6 7�� ?��Y�,���  ��  � o   8 9���� 0 zz  � m   : ;�� @����?���  ��  � o   < =���� 0 zz  � m   > ?�� @9����"��  ��  � o   @ A���� 0 zz  � m   B C�� @<�b@����  ��  � l  E T������ [   E T��� ]   E R��� l  E P������ \   E P��� ]   E N� � l  E L���� [   E L ]   E J l  E H���� \   E H o   E F���� 0 zz   m   F G		 @5򢶿]R��  ��   o   H I���� 0 zz   m   J K

 @bb�j1��  ��    o   L M���� 0 zz  � m   N O @w���c���  ��  � o   P Q���� 0 zz  � m   R S @ug	��D���  ��  � o      ���� 0 p  �  r   X _ a   X ] l  X [���� [   X [ o   X Y���� 0 zz   o   Y Z���� 0 zz  ��  ��   m   [ \ ?�       o      ���� 0 zz    r   ` i \   ` g l  ` e���� ^   ` e 1   ` c��
�� 
pi   m   c d���� ��  ��   o   e f���� 0 zz   o      ���� 0 z    !  r   j s"#" \   j q$%$ ]   j m&'& o   j k���� 0 zz  ' o   k l���� 0 p  % m   m p(( <��&3\
# o      ���� 0 zz  ! )��) r   t *+* [   t },-, \   t w./. o   t u���� 0 z  / o   u v���� 0 zz  - l  w |0����0 ^   w |121 1   w z��
�� 
pi  2 m   z {���� ��  ��  + o      ���� 0 z  ��  � 343 A   � �565 o   � ����� 0 x  6 m   � �77 >Ey��0�:4 8��8 r   � �9:9 o   � ����� 0 x  : o      ���� 0 z  ��  � k   � �;; <=< r   � �>?> ]   � �@A@ o   � ����� 0 x  A o   � ����� 0 x  ? o      ���� 0 zz  = B��B r   � �CDC [   � �EFE ]   � �GHG ^   � �IJI ]   � �KLK o   � ����� 0 zz  L l  � �M����M \   � �NON ]   � �PQP l  � �R����R [   � �STS ]   � �UVU l  � �W����W \   � �XYX ]   � �Z[Z l  � �\����\ [   � �]^] ]   � �_`_ l  � �a����a \   � �bcb ]   � �ded m   � �ff ?qk��v�e o   � ����� 0 zz  c m   � �gg ?�CA3>M���  ��  ` o   � ����� 0 zz  ^ m   � �hh @�K�/��  ��  [ o   � ����� 0 zz  Y m   � �ii @0C1�'����  ��  V o   � ����� 0 zz  T m   � �jj @3��w����  ��  Q o   � ����� 0 zz  O m   � �kk @ elΰ8��  ��  J l  � �l����l \   � �mnm ]   � �opo l  � �q����q [   � �rsr ]   � �tut l  � �v���v \   � �wxw ]   � �yzy l  � �{�~�}{ [   � �|}| ]   � �~~ l  � ���|�{� \   � ���� o   � ��z�z 0 zz  � m   � ��� @-{Y^��|  �{   o   � ��y�y 0 zz  } m   � ��� @Q��%��6�~  �}  z o   � ��x�x 0 zz  x m   � ��� @be�m5v���  �  u o   � ��w�w 0 zz  s m   � ��� @apV������  ��  p o   � ��v�v 0 zz  n m   � ��� @H�"
6���  ��  H o   � ��u�u 0 x  F o   � ��t�t 0 x  D o      �s�s 0 z  ��  � ��� Z  � ����r�q� o   � ��p�p 0 isneg isNeg� r   � ���� d   � ��� o   � ��o�o 0 z  � o      �n�n 0 z  �r  �q  � ��m� L   � ��� ^   � ���� o   � ��l�l 0 z  � l  � ���k�j� ^   � ���� 1   � ��i
�i 
pi  � m   � ��h�h ��k  �j  �m  � ��� l     �g�f�e�g  �f  �e  � ��� l     �d�c�b�d  �c  �b  � ��� l     �a�`�_�a  �`  �_  � ��� i  ~ ���� I     �^��]
�^ .Mth:Sinanull���     doub� o      �\�\ 0 x  �]  � Q     ���� L    �� I    �[��Z�[ 	0 _asin  � ��Y� c    ��� o    �X�X 0 x  � m    �W
�W 
nmbr�Y  �Z  � R      �V��
�V .ascrerr ****      � ****� o      �U�U 0 etext eText� �T��
�T 
errn� o      �S�S 0 enumber eNumber� �R��
�R 
erob� o      �Q�Q 0 efrom eFrom� �P��O
�P 
errt� o      �N�N 
0 eto eTo�O  � I    �M��L�M 
0 _error  � ��� m    �� ���  a s i n� ��� o    �K�K 0 etext eText� ��� o    �J�J 0 enumber eNumber� ��� o    �I�I 0 efrom eFrom� ��H� o    �G�G 
0 eto eTo�H  �L  � ��� l     �F�E�D�F  �E  �D  � ��� l     �C�B�A�C  �B  �A  � ��� i  � ���� I     �@��?
�@ .Mth:Cosanull���     doub� o      �>�> 0 x  �?  � Q      ���� L    �� \    ��� m    �=�= Z� l   ��<�;� I    �:��9�: 	0 _asin  � ��8� c    ��� o    �7�7 0 x  � m    �6
�6 
nmbr�8  �9  �<  �;  � R      �5��
�5 .ascrerr ****      � ****� o      �4�4 0 etext eText� �3��
�3 
errn� o      �2�2 0 enumber eNumber� �1��
�1 
erob� o      �0�0 0 efrom eFrom� �/��.
�/ 
errt� o      �-�- 
0 eto eTo�.  � I     �,��+�, 
0 _error  � ��� m    �� ���  a c o s� ��� o    �*�* 0 etext eText� ��� o    �)�) 0 enumber eNumber� ��� o    �(�( 0 efrom eFrom� ��'� o    �&�& 
0 eto eTo�'  �+  � ��� l     �%�$�#�%  �$  �#  � ��� l     �"�!� �"  �!  �   � ��� i  � ���� I     ���
� .Mth:Tananull���     doub� o      �� 0 x  �  � Q     *���� k    �� ��� r    ��� c    ��� o    �� 0 x  � m    �
� 
nmbr� o      �� 0 x  � ��� L   	 �� I   	 ���� 	0 _asin  � ��� ^   
 ��� o   
 �� 0 x  � l   ���� a    ��� l   ���� [       ]     o    �� 0 x   o    �� 0 x   m    �� �  �  � m     ?�      �  �  �  �  �  � R      �
� .ascrerr ****      � **** o      �� 0 etext eText �
� 
errn o      �
�
 0 enumber eNumber �		

�	 
erob	 o      �� 0 efrom eFrom
 ��
� 
errt o      �� 
0 eto eTo�  � I     *��� 
0 _error    m   ! " �  a t a n  o   " #�� 0 etext eText  o   # $�� 0 enumber eNumber  o   $ %� �  0 efrom eFrom �� o   % &���� 
0 eto eTo��  �  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ����    -----    �   
 - - - - - !"! l     ��#$��  #   hyperbolic   $ �%%    h y p e r b o l i c" &'& l     ��������  ��  ��  ' ()( i  � �*+* I     ��,��
�� .Mth:Sinhnull���     doub, o      ���� 0 x  ��  + Q     .-./- k    00 121 r    343 c    565 o    ���� 0 x  6 m    ��
�� 
nmbr4 o      ���� 0 x  2 7��7 L   	 88 ]   	 9:9 m   	 
;; ?�      : l  
 <����< \   
 =>= a   
 ?@? o   
 ���� 	0 __e__  @ o    ���� 0 x  > a    ABA o    ���� 	0 __e__  B d    CC o    ���� 0 x  ��  ��  ��  . R      ��DE
�� .ascrerr ****      � ****D o      ���� 0 etext eTextE ��FG
�� 
errnF o      ���� 0 enumber eNumberG ��HI
�� 
erobH o      ���� 0 efrom eFromI ��J��
�� 
errtJ o      ���� 
0 eto eTo��  / I   $ .��K���� 
0 _error  K LML m   % &NN �OO 
 a s i n hM PQP o   & '���� 0 etext eTextQ RSR o   ' (���� 0 enumber eNumberS TUT o   ( )���� 0 efrom eFromU V��V o   ) *���� 
0 eto eTo��  ��  ) WXW l     ��������  ��  ��  X YZY l     ��������  ��  ��  Z [\[ i  � �]^] I     ��_��
�� .Mth:Coshnull���     doub_ o      ���� 0 x  ��  ^ Q     .`ab` k    cc ded r    fgf c    hih o    ���� 0 x  i m    ��
�� 
nmbrg o      ���� 0 x  e j��j L   	 kk ]   	 lml m   	 
nn ?�      m l  
 o����o [   
 pqp a   
 rsr o   
 ���� 	0 __e__  s o    ���� 0 x  q a    tut o    ���� 	0 __e__  u d    vv o    ���� 0 x  ��  ��  ��  a R      ��wx
�� .ascrerr ****      � ****w o      ���� 0 etext eTextx ��yz
�� 
errny o      ���� 0 enumber eNumberz ��{|
�� 
erob{ o      ���� 0 efrom eFrom| ��}��
�� 
errt} o      ���� 
0 eto eTo��  b I   $ .��~���� 
0 _error  ~ � m   % &�� ��� 
 a c o s h� ��� o   & '���� 0 etext eText� ��� o   ' (���� 0 enumber eNumber� ��� o   ( )���� 0 efrom eFrom� ���� o   ) *���� 
0 eto eTo��  ��  \ ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Mth:Tanhnull���     doub� o      ���� 0 x  ��  � Q     =���� k    +�� ��� r    ��� c    ��� o    ���� 0 x  � m    ��
�� 
nmbr� o      ���� 0 x  � ���� L   	 +�� ^   	 *��� l  	 ������ \   	 ��� a   	 ��� o   	 ���� 	0 __e__  � o    ���� 0 x  � a    ��� o    ���� 	0 __e__  � d    �� o    ���� 0 x  ��  ��  � l   )������ [    )��� a     ��� o    ���� 	0 __e__  � o    ���� 0 x  � a     (��� o     %���� 	0 __e__  � d   % '�� o   % &���� 0 x  ��  ��  ��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   3 =������� 
0 _error  � ��� m   4 5�� ��� 
 a t a n h� ��� o   5 6���� 0 etext eText� ��� o   6 7���� 0 enumber eNumber� ��� o   7 8���� 0 efrom eFrom� ���� o   8 9���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   Logarithms   � ���    L o g a r i t h m s� ��� l     �������  ��  �  � ��� i  � ���� I      �~��}�~ 
0 _frexp  � ��|� o      �{�{ 0 m  �|  �}  � k     n�� ��� Z    ���z�y� =    ��� o     �x�x 0 m  � m    �w�w  � L    �� J    
�� ��� m    ��         � ��v� m    �u�u  �v  �z  �y  � ��� r    ��� A    ��� o    �t�t 0 m  � m    �s�s  � o      �r�r 0 isneg isNeg� ��� Z   "���q�p� o    �o�o 0 isneg isNeg� r    ��� d    �� o    �n�n 0 m  � o      �m�m 0 m  �q  �p  � ��� r   # &��� m   # $�l�l  � o      �k�k 0 e  � ��� W   ' [��� Z   7 V���j�� @   7 :� � o   7 8�i�i 0 m    m   8 9�h�h � k   = H  r   = B ^   = @ o   = >�g�g 0 m   m   > ?�f�f  o      �e�e 0 m   �d r   C H	
	 [   C F o   C D�c�c 0 e   m   D E�b�b 
 o      �a�a 0 e  �d  �j  � k   K V  r   K P ]   K N o   K L�`�` 0 m   m   L M�_�_  o      �^�^ 0 m   �] r   Q V \   Q T o   Q R�\�\ 0 e   m   R S�[�[  o      �Z�Z 0 e  �]  � F   + 6 @   + . o   + ,�Y�Y 0 m   m   , - ?�       A   1 4 o   1 2�X�X 0 m   m   2 3�W�W �  !  Z  \ h"#�V�U" o   \ ]�T�T 0 isneg isNeg# r   ` d$%$ d   ` b&& o   ` a�S�S 0 m  % o      �R�R 0 m  �V  �U  ! '�Q' L   i n(( J   i m)) *+* o   i j�P�P 0 m  + ,�O, o   j k�N�N 0 e  �O  �Q  � -.- l     �M�L�K�M  �L  �K  . /0/ l     �J�I�H�J  �I  �H  0 121 i  � �343 I      �G5�F�G 	0 _logn  5 6�E6 o      �D�D 0 x  �E  �F  4 k    ;77 898 Z    :;�C�B: B     <=< o     �A�A 0 x  = m    �@�@  ; R    �?>?
�? .ascrerr ****      � ****> m   
 @@ �AA 8 I n v a l i d   n u m b e r   ( m u s t   b e   > 0 ) .? �>B�=
�> 
errnB m    	�<�<�Y�=  �C  �B  9 CDC r    &EFE I      �;G�:�; 
0 _frexp  G H�9H o    �8�8 0 x  �9  �:  F J      II JKJ o      �7�7 0 x  K L�6L o      �5�5 0 e  �6  D MNM Z   '8OP�4QO G   ' 2RSR A   ' *TUT o   ' (�3�3 0 e  U m   ( )�2�2��S ?   - 0VWV o   - .�1�1 0 e  W m   . /�0�0 P k   5 �XX YZY Z   5 ^[\�/][ A   5 8^_^ o   5 6�.�. 0 x  _ m   6 7`` ?栞fK�\ l  ; Nabca k   ; Ndd efe r   ; @ghg \   ; >iji o   ; <�-�- 0 e  j m   < =�,�, h o      �+�+ 0 e  f klk r   A Fmnm \   A Dopo o   A B�*�* 0 x  p m   B Cqq ?�      n o      �)�) 0 z  l r�(r r   G Nsts [   G Luvu ]   G Jwxw m   G Hyy ?�      x o   H I�'�' 0 z  v m   J Kzz ?�      t o      �&�& 0 y  �(  b   (2 ^ 0.5) / 2   c �{{    ( 2   ^   0 . 5 )   /   2�/  ] k   Q ^|| }~} r   Q V� \   Q T��� o   Q R�%�% 0 x  � m   R S�$�$ � o      �#�# 0 z  ~ ��"� r   W ^��� [   W \��� ]   W Z��� m   W X�� ?�      � o   X Y�!�! 0 x  � m   Z [�� ?�      � o      � �  0 y  �"  Z ��� r   _ d��� ^   _ b��� o   _ `�� 0 z  � o   ` a�� 0 y  � o      �� 0 x  � ��� r   e j��� ]   e h��� o   e f�� 0 x  � o   f g�� 0 x  � o      �� 0 z  � ��� r   k ���� ^   k ���� ]   k x��� ]   k n��� o   k l�� 0 x  � o   l m�� 0 z  � l  n w���� \   n w��� ]   n u��� l  n s���� [   n s��� ]   n q��� m   n o�� ��D=�l�� o   o p�� 0 z  � m   q r�� @0b�s{��  �  � o   s t�� 0 z  � m   u v�� @P	"*?�  �  � l  x ����� \   x ���� ]   x ���� l  x ���� [   x ��� ]   x }��� l  x {���� \   x {��� o   x y�� 0 z  � m   y z�� @A�C�l��  �  � o   { |�
�
 0 z  � m   } ~�� @s��*�
�  �  � o    ��	�	 0 z  � m   � ��� @���?;�  �  � o      �� 0 z  � ��� r   � ���� o   � ��� 0 e  � o      �� 0 y  � ��� r   � ���� [   � ���� [   � ���� \   � ���� o   � ��� 0 z  � ]   � ���� o   � ��� 0 y  � m   � ��� ?+�\a�� o   � ��� 0 x  � ]   � ���� o   � ��� 0 e  � m   � ��� ?�0     � o      � �  0 z  �  �4  Q k   �8�� ��� Z   � ������� A   � ���� o   � ����� 0 x  � m   � ��� ?栞fK�� l  � ����� k   � ��� ��� r   � ���� \   � ���� o   � ����� 0 e  � m   � ����� � o      ���� 0 e  � ���� r   � ���� \   � ���� ]   � ���� m   � ����� � o   � ����� 0 x  � m   � ����� � o      ���� 0 x  ��  �   (2 ^ 0.5) / 2   � ���    ( 2   ^   0 . 5 )   /   2��  � r   � ���� \   � ���� o   � ����� 0 x  � m   � ����� � o      ���� 0 x  � ��� r   � ���� ]   � ���� o   � ����� 0 x  � o   � ����� 0 x  � o      ���� 0 z  � ��� r   ���� ^   ���� ]   � ���� ]   � �� � o   � ����� 0 x    o   � ����� 0 z  � l  � ����� [   � � ]   � � l  � ����� [   � � ]   � �	
	 l  � ����� [   � � ]   � � l  � ����� [   � � ]   � � l  � ����� [   � � ]   � � m   � � ?��� o   � ����� 0 x   m   � � ?���?Vd���  ��   o   � ����� 0 x   m   � � @Һ�i���  ��   o   � ����� 0 x   m   � � @,�r�>����  ��  
 o   � ����� 0 x   m   � � @1�֒K�R��  ��   o   � ����� 0 x   m   � � @�c}~ݝ��  ��  � l  � ����  [   �!"! ]   � �#$# l  � �%����% [   � �&'& ]   � �()( l  � �*����* [   � �+,+ ]   � �-.- l  � �/����/ [   � �010 ]   � �232 l  � �4����4 [   � �565 o   � ����� 0 x  6 m   � �77 @&� �����  ��  3 o   � ����� 0 x  1 m   � �88 @F�,N���  ��  . o   � ����� 0 x  , m   � �99 @T�3�&����  ��  ) o   � ����� 0 x  ' m   � �:: @Q���^���  ��  $ o   � ����� 0 x  " m   � ;; @7 
�&5��  ��  � o      ���� 0 y  � <=< Z  >?����> >  @A@ o  ���� 0 e  A m  ����  ? r  BCB \  DED o  ���� 0 y  E ]  FGF o  ���� 0 e  G m  HH ?+�\a�C o      ���� 0 y  ��  ��  = IJI r  KLK \  MNM o  ���� 0 y  N l O����O ^  PQP o  ���� 0 z  Q m  ���� ��  ��  L o      ���� 0 y  J RSR r  $TUT [  "VWV o   ���� 0 x  W o   !���� 0 y  U o      ���� 0 z  S X��X Z %8YZ����Y >  %([\[ o  %&���� 0 e  \ m  &'����  Z r  +4]^] [  +2_`_ o  +,���� 0 z  ` ]  ,1aba o  ,-���� 0 e  b m  -0cc ?�0     ^ o      ���� 0 z  ��  ��  ��  N d��d L  9;ee o  9:���� 0 z  ��  2 fgf l     ��������  ��  ��  g hih l     ��������  ��  ��  i jkj l     ��������  ��  ��  k lml i  � �non I     ��p��
�� .Mth:Lognnull���     doubp o      ���� 0 x  ��  o Q     qrsq L    tt I    ��u���� 	0 _logn  u v��v c    wxw o    ���� 0 x  x m    ��
�� 
nmbr��  ��  r R      ��yz
�� .ascrerr ****      � ****y o      ���� 0 etext eTextz ��{|
�� 
errn{ o      ���� 0 enumber eNumber| ��}~
�� 
erob} o      ���� 0 efrom eFrom~ ����
�� 
errt o      ���� 
0 eto eTo��  s I    ������� 
0 _error  � ��� m    �� ���  l o g n� ��� o    ���� 0 etext eText� ��� o    ���� 0 enumber eNumber� ��� o    ���� 0 efrom eFrom� ���� o    ���� 
0 eto eTo��  ��  m ��� l     ��������  ��  ��  � ��� l     ������  �  �  � ��� i  � ���� I     ���
� .Mth:Lo10null���     doub� o      �� 0 x  �  � Q     $���� l   ���� L    �� ^    ��� ]    ��� l   ���� ^    ��� I    ���� 	0 _logn  � ��� c    ��� o    �� 0 x  � m    �
� 
nmbr�  �  � m    �� @k���T��  �  � m    �� @r�     � m    �� @r�    j�   correct for minor drift   � ��� 0   c o r r e c t   f o r   m i n o r   d r i f t� R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �~�~ 0 efrom eFrom� �}��|
�} 
errt� o      �{�{ 
0 eto eTo�|  � I    $�z��y�z 
0 _error  � ��� m    �� ��� 
 l o g 1 0� ��� o    �x�x 0 etext eText� ��� o    �w�w 0 enumber eNumber� ��� o    �v�v 0 efrom eFrom� ��u� o     �t�t 
0 eto eTo�u  �y  � ��� l     �s�r�q�s  �r  �q  � ��� l     �p�o�n�p  �o  �n  � ��� i  � ���� I     �m��
�m .Mth:Logbnull���     doub� o      �l�l 0 x  � �k��j
�k 
Base� o      �i�i 0 b  �j  � Q     '���� L    �� ^    ��� I    �h��g�h 	0 _logn  � ��f� c    ��� o    �e�e 0 x  � m    �d
�d 
nmbr�f  �g  � l   ��c�b� I    �a��`�a 	0 _logn  � ��_� c    ��� o    �^�^ 0 b  � m    �]
�] 
nmbr�_  �`  �c  �b  � R      �\��
�\ .ascrerr ****      � ****� o      �[�[ 0 etext eText� �Z��
�Z 
errn� o      �Y�Y 0 enumber eNumber� �X��
�X 
erob� o      �W�W 0 efrom eFrom� �V��U
�V 
errt� o      �T�T 
0 eto eTo�U  � I    '�S��R�S 
0 _error  � ��� m    �� ���  l o g b� ��� o     �Q�Q 0 etext eText� ��� o     !�P�P 0 enumber eNumber� ��� o   ! "�O�O 0 efrom eFrom� ��N� o   " #�M�M 
0 eto eTo�N  �R  � ��� l     �L�K�J�L  �K  �J  � ��I� l     �H�G�F�H  �G  �F  �I       (�E���� h r ~ ��������������� 	
�E  � &�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� �
�D 
pimr�C 0 _support  �B 
0 _error  �A 	0 __e__  �@ 0 _isequaldelta _isEqualDelta�? $0 _mindecimalrange _minDecimalRange�> $0 _maxdecimalrange _maxDecimalRange�= (0 _asintegerproperty _asIntegerProperty�< ,0 _makenumberformatter _makeNumberFormatter�; "0 _setbasicformat _setBasicFormat�:  0 _nameforformat _nameForFormat
�9 .Mth:FNumnull���     nmbr
�8 .Mth:PNumnull���     ctxt
�7 .Mth:NuHenull���     ****
�6 .Mth:HeNunull���     ctxt
�5 .Mth:DeRanull���     doub
�4 .Mth:RaDenull���     doub
�3 .Mth:Abs_null���     nmbr
�2 .Mth:CmpNnull���     ****
�1 .Mth:MinNnull���     ****
�0 .Mth:MaxNnull���     ****
�/ .Mth:RouNnull���     nmbr�. 0 _sin  
�- .Mth:Sin_null���     doub
�, .Mth:Cos_null���     doub
�+ .Mth:Tan_null���     doub�* 	0 _asin  
�) .Mth:Sinanull���     doub
�( .Mth:Cosanull���     doub
�' .Mth:Tananull���     doub
�& .Mth:Sinhnull���     doub
�% .Mth:Coshnull���     doub
�$ .Mth:Tanhnull���     doub�# 
0 _frexp  �" 	0 _logn  
�! .Mth:Lognnull���     doub
�  .Mth:Lo10null���     doub
� .Mth:Logbnull���     doub� ��    ��
� 
cobj    � 
� 
frmk�   ��
� 
cobj    �
� 
osax�  �    � /
� 
scpt� � 7���� 
0 _error  � ��   ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�   ���
�	�� 0 handlername handlerName� 0 etext eText�
 0 enumber eNumber�	 0 efrom eFrom� 
0 eto eTo  G��� � &0 throwcommanderror throwCommandError� b  ࠡ����+ � � ����� (0 _asintegerproperty _asIntegerProperty� ��   � �����  0 thevalue theValue�� 0 propertyname propertyName�� 0 minvalue minValue�   ���������� 0 thevalue theValue�� 0 propertyname propertyName�� 0 minvalue minValue�� 0 n   	������������ � �
�� 
long
�� 
doub
�� 
bool
�� 
errn���Y��   ������
�� 
errn���Y��  � 9 (��&E�O���&
 ���& )��lhY hO�W X  )��l�%�%� �� ����� !���� ,0 _makenumberformatter _makeNumberFormatter�� ��"�� "  �������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 	thenumber 	theNumber��    ���������������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 	thenumber 	theNumber�� 0 asocformatter asocFormatter�� 0 formatrecord formatRecord�� 0 s  �� 0 etext eText! G��������������������������������������������=��������d�������������������#������������������~$���������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  
�� 
kocl
�� 
reco
�� .corecnte****       ****
�� 
pcls
�� 
MthR
�� 
MthA�� 0 requiredvalue RequiredValue
�� 
MthB
�� 
msng
�� 
MthC
�� 
MthD
�� 
MthE
�� 
MthF
�� 
MthG
�� 
MthH�� �� 60 asoptionalrecordparameter asOptionalRecordParameter�� "0 _setbasicformat _setBasicFormat�� (0 _asintegerproperty _asIntegerProperty�� 60 setminimumfractiondigits_ setMinimumFractionDigits_����� 60 setmaximumfractiondigits_ setMaximumFractionDigits_�� <0 setminimumsignificantdigits_ setMinimumSignificantDigits_�� 60 setusessignificantdigits_ setUsesSignificantDigits_�� <0 setmaximumsignificantdigits_ setMaximumSignificantDigits_
�� 
ctxt
�� 
leng
�� 
errn���Y�� ,0 setdecimalseparator_ setDecimalSeparator_�  # ���
� 
errn��\�  � 60 setusesgroupingseparator_ setUsesGroupingSeparator_� .0 setgroupingseparator_ setGroupingSeparator_
� MRndRNhE� @0 nsnumberformatterroundhalfeven NSNumberFormatterRoundHalfEven� $0 setroundingmode_ setRoundingMode_
� MRndRNhT� @0 nsnumberformatterroundhalfdown NSNumberFormatterRoundHalfDown
� MRndRNhF� <0 nsnumberformatterroundhalfup NSNumberFormatterRoundHalfUp
� MRndRN_T� 80 nsnumberformatterrounddown NSNumberFormatterRoundDown
� MRndRN_F� 40 nsnumberformatterroundup NSNumberFormatterRoundUp
� MRndRN_U� >0 nsnumberformatterroundceiling NSNumberFormatterRoundCeiling
� MRndRN_D� :0 nsnumberformatterroundfloor NSNumberFormatterRoundFloor$ ���
� 
errn��Y�  � 0 etext eText
� 
enum� � .0 throwinvalidparameter throwInvalidParameter� *0 asnslocaleparameter asNSLocaleParameter� 0 
setlocale_ 
setLocale_�����,j+ j+ E�Ok�kv��l k Ab  ����b  �,��������a �a �a �a a m+ E�O*���,�m+ O��,� !�*��,a jm+ k+ O�a k+ OPY hO��,� �*��,a jm+ k+ OPY hO��,� �*��,a jm+ k+ O�ek+ Y hO��,� �*��,a  jm+ k+ !O�ek+ Y hO�a ,� G 0�a ,a "&E�O�a #,j  )a $a %lhY hO��k+ &W X ' ()a $a %la )Y hO�a ,� H 1�a ,a "&E�O�a #,j  �fk+ *Y �ek+ *O��k+ +W X ' ()a $a %la ,Y hO�a ,� ��a ,a -  ��a .,k+ /Y ��a ,a 0  ��a 1,k+ /Y ��a ,a 2  ��a 3,k+ /Y r�a ,a 4  ��a 5,k+ /Y Y�a ,a 6  ��a 7,k+ /Y @�a ,a 8  ��a 9,k+ /Y '�a ,a :  ��a ;,k+ /Y )a $a %la <Y hY  *���m+ W X ' =)ja >W X ? =b  �a @�a Alv�a B+ CO�b  �a Dl+ Ek+ FO�� ����%&�� "0 _setbasicformat _setBasicFormat� �'� '  ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 	thenumber 	theNumber�  % ���� 0 asocformatter asocFormatter� 0 
formatname 
formatName� 0 	thenumber 	theNumber& "�������������������������~�}�|�{�z�y�x�w�v�
� MthZMth0
� 
msng
� misccura� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle� "0 setnumberstyle_ setNumberStyle_
� 
pcls
� 
long� 40 nsnumberformatternostyle NSNumberFormatterNoStyle
� 
bool� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle� 60 setminimumfractiondigits_ setMinimumFractionDigits_��� 60 setmaximumfractiondigits_ setMaximumFractionDigits_� 60 setusesgroupingseparator_ setUsesGroupingSeparator_
� MthZMth3
� MthZMth1
� MthZMth2
� MthZMth5� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
� MthZMth4� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
� MthZMth6� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
� 
kocl
�~ 
ctxt
�} .corecnte****       ****�| 0 
setformat_ 
setFormat_
�{ 
errn�z�Y
�y 
erob
�x 
errt
�w 
enum�v �G��  ���  ���,k+ Y ���,�  ���,k+ Y tb  '�	 �b  '�&
 b  �	 �b  �&�&
 �j �& $���,k+ O�kk+ 
O��k+ O�fk+ OPY ���,k+ O�kk+ 
O��k+ OPY ���  ���,k+ Y ���  ���,k+ Y ��a   ���,k+ Y t�a   ��a ,k+ Y _�a   ��a ,k+ Y J�a   ��a ,k+ Y 5�kva a l j ��k+ Y )a a a �a a a  a !� �u��t�s()�r�u  0 _nameforformat _nameForFormat�t �q*�q *  �p�p 0 formatstyle formatStyle�s  ( �o�o 0 formatstyle formatStyle) �n��m��l�k�j�i&(
�n MthZMth1
�m MthZMth2
�l MthZMth5
�k MthZMth4
�j MthZMth3
�i MthZMth6�r I��  �Y ?��  �Y 4��  �Y )��  �Y ��  �Y ��  �Y �%�%� �h9�g�f+,�e
�h .Mth:FNumnull���     nmbr�g 0 	thenumber 	theNumber�f �d-.
�d 
Usin- {�c�b�a�c 0 formatstyle formatStyle�b  
�a MthZMth0. �`/�_
�` 
Loca/ {�^�]E�^ 0 
localecode 
localeCode�]  �_  + 	�\�[�Z�Y�X�W�V�U�T�\ 0 	thenumber 	theNumber�[ 0 formatstyle formatStyle�Z 0 
localecode 
localeCode�Y 0 asocformatter asocFormatter�X 0 
asocstring 
asocString�W 0 etext eText�V 0 enumber eNumber�U 0 efrom eFrom�T 
0 eto eTo, �S�R�Qaf�P�O�N�M�L�K�J�I��H�G0��F�E
�S 
kocl
�R 
nmbr
�Q .corecnte****       ****�P �O 60 throwinvalidparametertype throwInvalidParameterType�N ,0 _makenumberformatter _makeNumberFormatter�M &0 stringfromnumber_ stringFromNumber_
�L 
msng
�K 
errn�J�Y
�I 
erob
�H 
ctxt�G 0 etext eText0 �D�C1
�D 
errn�C 0 enumber eNumber1 �B�A2
�B 
erob�A 0 efrom eFrom2 �@�?�>
�@ 
errt�? 
0 eto eTo�>  �F �E 
0 _error  �e e P�kv��l j  b  �����+ Y hO*���m+ E�O��k+ E�O��  )�����Y hO��&W X  *a ����a + � �=��<�;34�:
�= .Mth:PNumnull���     ctxt�< 0 thetext theText�; �956
�9 
Usin5 {�8�7�6�8 0 formatstyle formatStyle�7  
�6 MthZMth06 �57�4
�5 
Loca7 {�3�2��3 0 
localecode 
localeCode�2  �4  3 
�1�0�/�.�-�,�+�*�)�(�1 0 thetext theText�0 0 formatstyle formatStyle�/ 0 
localecode 
localeCode�. 0 asocformatter asocFormatter�- 0 
asocnumber 
asocNumber�, $0 localeidentifier localeIdentifier�+ 0 etext eText�* 0 enumber eNumber�) 0 efrom eFrom�( 
0 eto eTo4 �'�&�%���$�#�"�!� ������$�(*��8=��
�' 
kocl
�& 
ctxt
�% .corecnte****       ****�$ �# 60 throwinvalidparametertype throwInvalidParameterType
�" 
msng�! ,0 _makenumberformatter _makeNumberFormatter�  &0 numberfromstring_ numberFromString_� 
0 locale  � $0 localeidentifier localeIdentifier
� 
leng
� 
errn��Y
� 
erob�  0 _nameforformat _nameForFormat
� 
****� 0 etext eText8 ��9
� 
errn� 0 enumber eNumber9 ��:
� 
erob� 0 efrom eFrom: ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �: � ��kv��l j  b  �����+ Y hO*���m+ E�O��k+ 	E�O��  J�j+ 
j+ �&E�O��,j  �E�Y 	�%�%E�O)a a a ��a *�k+ %a %�%a %Y hO�a &W X  *a ����a + � �Y��;<�

� .Mth:NuHenull���     ****� 0 	thenumber 	theNumber� �	=>
�	 
Plac= {���� 0 	chunksize 	chunkSize�  �  > �?�
� 
Pref? {���� 0 	hasprefix 	hasPrefix�  
� boovfals�  ; � ���������������������������  0 	thenumber 	theNumber�� 0 	chunksize 	chunkSize�� 0 	hasprefix 	hasPrefix�� 0 hextext hexText�� 0 	hexprefix 	hexPrefix�� 0 padtext padText�� 0 maxsize maxSize�� 0 
resultlist 
resultList�� 0 aref aRef�� 0 oldtids oldTIDs�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo< >s�����������������������������������
!,1@V����g�������@������������A���	������AN��Bk������ (0 asintegerparameter asIntegerParameter�� (0 asbooleanparameter asBooleanParameter
�� 
kocl
�� 
list
�� .corecnte****       ****�� 00 aswholenumberparameter asWholeNumberParameter�� 
�� 
bool
�� 
long�� �� .0 throwinvalidparameter throwInvalidParameter������ 
�� 
cobj
�� 
leng�� 0 
resultlist 
resultList@ ��C����DE��
�� .ascrinit****      � ****C k     	FF �����  ��  ��  D ���� 
0 _list_  E ����
�� 
cobj�� 
0 _list_  �� 
b   �-E��� 
0 _list_  
�� 
pcnt
�� 
doub
�� 
errn���\��  A ������
�� 
errn���\��  
�� 
ctxt
�� 
ascr
�� 
txdl�� 0 etext eTextB ����G
�� 
errn�� 0 enumber eNumberG ����H
�� 
erob�� 0 efrom eFromH ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �
��b  ��l+ E�Ob  ��l+ E�O�kv��l j b  ��l+ E�O�j
 ���& b  �����+ Y hOa E�O�j I�j	 �a �$�& (b  �a �a a �$%a %a �$k%�+ Y hOa E�O�'E�Y Ca E�O�j	 �a �$k�& (b  �a �a a �$%a %a �$k%�+ Y hO� �a %E�Y hO &h�ja a �a #k/�%E�O�a "E�[OY��O h�a ,�a �%E�[OY��O��%Y{�k
 ���& b  �a  �a !�+ Y hOa "a �$klvE[a k/E�Z[a l/E�ZO �kh�a #%E�[OY��Oa $a %K &S�O ӧa ',[�a l kh  ;�a (,�&E�O��a (,a )&
 �j�&
 ���& )a *a +lhY hW :X , -�� b  �a .�a /a �$k%�+ Y b  �a 0�a 1�+ Oa 2E�O &h�ja 3a �a #k/�%E�O�a "E�[OY��O��%[a 4\[Z�'\Zi2�a (,F[OY�AO_ 5a 6,E�Oa 7_ 5a 6,FO� a 8�a ',%E�Y �a ',a 4&E�O�_ 5a 6,FO�W X 9 :*a ;����a <+ =� ��{����IJ��
�� .Mth:HeNunull���     ctxt�� 0 hextext hexText�� ��KL
�� 
PlacK {���� 0 	chunksize 	chunkSize�  �  L �M�
� 
PrecM {���� 0 	isprecise 	isPrecise�  
� boovtrue�  I ������������� 0 hextext hexText� 0 	chunksize 	chunkSize� 0 	isprecise 	isPrecise� 0 	thenumber 	theNumber� 0 
isnegative 
isNegative� 0 charref charRef� 0 i  � 0 
resultlist 
resultList� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToJ 2�����������������������������N��+>�bd�kO�����P���� "0 astextparameter asTextParameter� (0 asintegerparameter asIntegerParameter� 
� 
bool
� 
long� � .0 throwinvalidparameter throwInvalidParameter� (0 asbooleanparameter asBooleanParameter
� 
ctxt
� 
kocl
� 
cobj
� .corecnte****       ****� 
� misccura
� 
psof
� 
psin
� .sysooffslong    ��� null
� 
errn��@�  N ���
� 
errn��@�  ��Y
� 
erob
� 
leng� 0 
resultlist 
resultListO �Q��RS�
� .ascrinit****      � ****Q k     TT k��  �  �  R �� 
0 _list_  S �� 
0 _list_  � jv�� 
0 _list_  � 0 etext eTextP ��U
� 
errn� 0 enumber eNumberU ��V
� 
erob� 0 efrom eFromV ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ��cN��Fb  ��l+ E�Ob  ��l+ E�O�j
 ���& b  �����+ Y hOb  ��l+ E�O�j  � �jE�O��E�O� �[a \[Zl\Zi2E�Y hO�a  �[a \[Zm\Zi2E�Y hO U�[a a l kh �a  E�Oa  *a �a a � UE�O�j  )a a lhY hO��kE�[OY��W X  )a a a  ��a !O�	 	��k �& )a a a  ��a "Y hO� 	�'E�Y hO�Y�a #,�#j )a a a  ��a $�%a %%Y hOa &a 'K (S�O �k�a #,E�h jE�O |�[a \[Z�\Z��k2[a a l kh �a  E�Oa  *a �a a )� UE�O�j  &)a a a  �[a \[Z�\Z��k2�a *Y hO��kE�[OY��O�	 	��k �& &)a a a  �[a \[Z�\Z��k2�a +Y hO��a ,,6F[OY�<O�a ,,EVW X - .*a /����a 0+ 1� �~	�}�|WX�{
�~ .Mth:DeRanull���     doub�} 0 x  �|  W �z�y�x�w�v�z 0 x  �y 0 etext eText�x 0 enumber eNumber�w 0 efrom eFrom�v 
0 eto eToX �u�t�s�rY	#�q�p
�u 
doub
�t 
pi  �s ��r 0 etext eTextY �o�nZ
�o 
errn�n 0 enumber eNumberZ �m�l[
�m 
erob�l 0 efrom eFrom[ �k�j�i
�k 
errt�j 
0 eto eTo�i  �q �p 
0 _error  �{  ��&��! W X  *塢���+ � �h	3�g�f\]�e
�h .Mth:RaDenull���     doub�g 0 x  �f  \ �d�c�b�a�`�d 0 x  �c 0 etext eText�b 0 enumber eNumber�a 0 efrom eFrom�` 
0 eto eTo] �_�^�]�\^	K�[�Z
�_ 
doub
�^ 
pi  �] ��\ 0 etext eText^ �Y�X_
�Y 
errn�X 0 enumber eNumber_ �W�V`
�W 
erob�V 0 efrom eFrom` �U�T�S
�U 
errt�T 
0 eto eTo�S  �[ �Z 
0 _error  �e  ��&��!!W X  *塢���+ � �R	]�Q�Pab�O
�R .Mth:Abs_null���     nmbr�Q 0 x  �P  a �N�M�L�K�J�N 0 x  �M 0 etext eText�L 0 enumber eNumber�K 0 efrom eFrom�J 
0 eto eTob �I�Hc	|�G�F
�I 
nmbr�H 0 etext eTextc �E�Dd
�E 
errn�D 0 enumber eNumberd �C�Be
�C 
erob�B 0 efrom eFrome �A�@�?
�A 
errt�@ 
0 eto eTo�?  �G �F 
0 _error  �O * ��&E�O�j �'Y �W X  *㡢���+ � �>	��=�<fg�;
�> .Mth:CmpNnull���     ****�= �:h�: h  �9�8�9 0 n1  �8 0 n2  �<  f 	�7�6�5�4�3�2�1�0�/�7 0 n1  �6 0 n2  �5 0 dn  �4 0 dm  �3 0 d  �2 0 etext eText�1 0 enumber eNumber�0 0 efrom eFrom�/ 
0 eto eTog �.�-�,�+�*�)�(i
�'�&
�. 
kocl
�- 
long
�, .corecnte****       ****
�+ 
doub
�* 
cobj
�) 
bool�( 0 etext eTexti �%�$j
�% 
errn�$ 0 enumber eNumberj �#�"k
�# 
erob�" 0 efrom eFromk �!� �
�! 
errt�  
0 eto eTo�  �' �& 
0 _error  �; � ���lv��l l  ��  jY hY s��&��&lvE[�k/E�Z[�l/E�ZO�j  b  � E�Y b  � E�O�'E�O�� ��lvE[�k/E�Z[�l/E�ZY hO��E�O��	 ���& jY hO�� iY kW X  *襦���+ 
� �
��lm�
� .Mth:MinNnull���     ****� 0 thelist theList�  l 	���������� 0 thelist theList� 0 
listobject 
listObject� 0 	theresult 	theResult� 0 aref aRef� 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTom �
n�������
o
U�	�� 0 
listobject 
listObjectn �p��qr�
� .ascrinit****      � ****p k     ss 
��  �  �  q �� 
0 _list_  r �� � "0 aslistparameter asListParameter�  
0 _list_  � b  b   k+  �� 
0 _list_  
� 
cobj
� 
nmbr
� 
kocl
� .corecnte****       ****
� 
pcnt�
 0 etext eTexto ����t
�� 
errn�� 0 enumber eNumbert ����u
�� 
erob�� 0 efrom eFromu ������
�� 
errt�� 
0 eto eTo��  �	 � 
0 _error  � X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+ � ��
e����vw��
�� .Mth:MaxNnull���     ****�� 0 thelist theList��  v 	�������������������� 0 thelist theList�� 0 
listobject 
listObject�� 0 	theresult 	theResult�� 0 aref aRef�� 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTow ��
mx��������������y
������� 0 
listobject 
listObjectx ��z����{|��
�� .ascrinit****      � ****z k     }} 
m����  ��  ��  { ���� 
0 _list_  | ������ "0 aslistparameter asListParameter�� 
0 _list_  �� b  b   k+  ��� 
0 _list_  
�� 
cobj
�� 
nmbr
�� 
kocl
�� .corecnte****       ****
�� 
pcnt�� 0 etext eTexty ����~
�� 
errn�� 0 enumber eNumber~ ����
�� 
erob�� 0 efrom eFrom ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� X G��K S�O��,�k/�&E�O +��,[��l kh ��,�&E�O�� �E�Y h[OY��O�W X 	 
*륦���+   ��
���������
�� .Mth:RouNnull���     nmbr�� 0 num  �� ����
�� 
Plac� {�������� 0 decimalplaces decimalPlaces��  ��  � �����
�� 
Dire� {�������� &0 roundingdirection roundingDirection��  
�� MRndRNhE��  � ���������������� 0 num  �� 0 decimalplaces decimalPlaces�� &0 roundingdirection roundingDirection�� 0 themultiplier theMultiplier�� 0 etext eText�� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� 
��
����.�L������-���N��� "0 asrealparameter asRealParameter� (0 asintegerparameter asIntegerParameter� 

� MRndRNhE
� MRndRNhT
� MRndRNhF
� MRndRN_T
� MRndRN_F
� MRndRN_U
� 
bool
� MRndRN_D� >0 throwinvalidconstantparameter throwInvalidConstantParameter� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O�j �$E�O�� � �!E�Y hO��  3��lv�l!k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y��  1��lv�k#kv 
�k"E�Y �j ��k"E�Y 	��k"E�Y ��  C��lv�k#kv �j �k"kE�Y 	�k"kE�Y �j ��k"E�Y 	��k"E�Y ���  
�k"E�Y ���  ,�k#j  
�k"E�Y �j �k"kE�Y 	�k"kE�Y a��  $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y 9�a   $�j
 	�k#j �& 
�k"E�Y 	�k"kE�Y b  �a l+ O�j  	�k"Y �j 	��"Y ��!W X  *a ����a +  �j������ 0 _sin  � ��� �  �� 0 x  �  � ������� 0 x  � 0 isneg isNeg� 0 y  � 0 z  � 0 z2  � 0 zz  � ������������ !CDEFGH�h
� 
pi  � �� � � 
� 
bool� ��#��! E�O�jE�O� 	�'E�Y hO���! k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��#E�O�m �E�O��E�Y hO��� �� �� E�O�� E�O�k 
 �l �& *�l!�� � �� �� �� a � a  E�Y +��� a � a � a � a � a � a  E�O� 	�'E�Y hO� �[�����
� .Mth:Sin_null���     doub� 0 x  �  � ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ����o��
� 
nmbr� 0 _sin  � 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �  *��&k+ W X  *䡢���+  ��~�}���|
� .Mth:Cos_null���     doub�~ 0 x  �}  � �{�z�y�x�w�{ 0 x  �z 0 etext eText�y 0 enumber eNumber�x 0 efrom eFrom�w 
0 eto eTo� �v�u�t�s���r�q
�v 
nmbr�u Z�t 0 _sin  �s 0 etext eText� �p�o�
�p 
errn�o 0 enumber eNumber� �n�m�
�n 
erob�m 0 efrom eFrom� �l�k�j
�l 
errt�k 
0 eto eTo�j  �r �q 
0 _error  �| ! *��&�k+ W X  *塢���+  �i��h�g���f
�i .Mth:Tan_null���     doub�h 0 x  �g  � 
�e�d�c�b�a�`�_�^�]�\�e 0 x  �d 0 isneg isNeg�c 0 y  �b 0 z  �a 0 z2  �` 0 zz  �_ 0 etext eText�^ 0 enumber eNumber�] 0 efrom eFrom�\ 
0 eto eTo� �[�Z�Y�X�W�V�U�T��S�R�Q�P'*-;PQRefgh�O�N���M�L
�[ 
nmbr�Z Z�Y
�X 
bool
�W 
errn�V�s
�U 
erob�T �Sh
�R 
pi  �Q ��P �O �N 0 etext eText� �K�J�
�K 
errn�J 0 enumber eNumber� �I�H�
�I 
erob�H 0 efrom eFrom� �G�F�E
�G 
errt�F 
0 eto eTo�E  �M �L 
0 _error  �f ��&E�O�� 
 �� �& )�����Y hO��#��! E�O�jE�O� 	�'E�Y hO���!!k"E�O��� k"� E�O�l#k  �kE�O�kE�Y hO��� �� �a  E�O�� E�O�a  4��� a � a � a  �a � a � a � a !E�Y �E�O�l 
 	�a  �& 
i�!E�Y hO� 	�'E�Y hO�W X  *a ����a +  �D��C�B���A�D 	0 _asin  �C �@��@ �  �?�? 0 x  �B  � �>�=�<�;�:�> 0 x  �= 0 isneg isNeg�< 0 zz  �; 0 p  �: 0 z  � �9�8�7�6�������	
�5(7fghijk������4
�9 
errn�8�Y
�7 
erob�6 
�5 
pi  �4 ��A ��jE�O� 	�'E�Y hO�k )�����Y hO�� Xk�E�O�� �� �� �� � ��� �� �� �!E�O���$E�O_ �!�E�O�� a E�O��_ �!E�Y ]�a  �E�Y O�� E�O�a � a � a � a � a � a  �a � a � a � a � a !� �E�O� 	�'E�Y hO�_ a !! �3��2�1���0
�3 .Mth:Sinanull���     doub�2 0 x  �1  � �/�.�-�,�+�/ 0 x  �. 0 etext eText�- 0 enumber eNumber�, 0 efrom eFrom�+ 
0 eto eTo� �*�)�(���'�&
�* 
nmbr�) 	0 _asin  �( 0 etext eText� �%�$�
�% 
errn�$ 0 enumber eNumber� �#�"�
�# 
erob�" 0 efrom eFrom� �!� �
�! 
errt�  
0 eto eTo�  �' �& 
0 _error  �0  *��&k+ W X  *䡢���+  �������
� .Mth:Cosanull���     doub� 0 x  �  � ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� ��������� Z
� 
nmbr� 	0 _asin  � 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ��
�	
� 
errt�
 
0 eto eTo�	  � � 
0 _error  � ! �*��&k+ W X  *塢���+  �������
� .Mth:Tananull���     doub� 0 x  �  � ����� � 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom�  
0 eto eTo� �����������
�� 
nmbr�� 	0 _asin  �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � + ��&E�O*��� k�$!k+ W X  *塢���+ 	 ��+��������
�� .Mth:Sinhnull���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ��;���N����
�� 
nmbr�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+ 
 ��^��������
�� .Mth:Coshnull���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ��n��������
�� 
nmbr�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� / ��&E�O�b  �$b  �'$ W X  *䡢���+  �����������
�� .Mth:Tanhnull���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ���������
�� 
nmbr�� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �� � 
0 _error  �� > -��&E�Ob  �$b  �'$b  �$b  �'$!W X  *㡢���+  �������� 
0 _frexp  � ��� �  �� 0 m  �  � ���� 0 m  � 0 isneg isNeg� 0 e  � ��
� 
bool� o�j  
�jlvY hO�jE�O� 	�'E�Y hOjE�O 3h��	 �k�&�k �l!E�O�kE�Y �l E�O�kE�[OY��O� 	�'E�Y hO��lv �4������ 	0 _logn  � ��� �  �� 0 x  �  � ����� 0 x  � 0 e  � 0 z  � 0 y  � ��@����`q��������789:;
� 
errn��Y� 
0 _frexp  
� 
cobj���
� 
bool�<�j )��l�Y hO*�k+ E[�k/E�Z[�l/E�ZO��
 �l�& j�� �kE�O��E�O� �E�Y �kE�O� �E�O��!E�O�� E�O�� � �� � ��� �� �!E�O�E�O��� ��a  E�Y ��� �kE�Ol� kE�Y �kE�O�� E�O�� a � a � a � a � a � a  �a � a � a � a � a !E�O�j ��� E�Y hO��l!E�O��E�O�j ��a  E�Y hO� �o�����
� .Mth:Lognnull���     doub� 0 x  �  � ������ 0 x  � 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� �������
� 
nmbr� 	0 _logn  � 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  � � 
0 _error  �  *��&k+ W X  *䡢���+  �����������
�� .Mth:Lo10null���     doub�� 0 x  ��  � ������������ 0 x  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 
��~����}���|�{
� 
nmbr�~ 	0 _logn  �} 0 etext eText� �z�y�
�z 
errn�y 0 enumber eNumber� �x�w�
�x 
erob�w 0 efrom eFrom� �v�u�t
�v 
errt�u 
0 eto eTo�t  �| �{ 
0 _error  �� % *��&k+ �!� �!W X  *硢���+ 	 �s��r�q���p
�s .Mth:Logbnull���     doub�r 0 x  �q �o�n�m
�o 
Base�n 0 b  �m  � �l�k�j�i�h�g�l 0 x  �k 0 b  �j 0 etext eText�i 0 enumber eNumber�h 0 efrom eFrom�g 
0 eto eTo� �f�e�d���c�b
�f 
nmbr�e 	0 _logn  �d 0 etext eText� �a�`�
�a 
errn�` 0 enumber eNumber� �_�^�
�_ 
erob�^ 0 efrom eFrom� �]�\�[
�] 
errt�\ 
0 eto eTo�[  �c �b 
0 _error  �p ( *��&k+ *��&k+ !W X  *䢣���+ ascr  ��ޭ
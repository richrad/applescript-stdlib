FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� FormatLib -- parse and format AppleScript values

Notes:

- NSNumberFormatters, NSDateFormatters, etc. (like all other ASOC objects) shouldn't be retained in library (or script objects returned by it) as that breaks store script/save/autosave (caveat: if there is a significant performance difference between creating a formatter once and reusing it vs creating it each time, DateFormatterObjects could be returned as an _alternative_ to using `parse date`/`format date` handlers where user really needs the extra speed; however, documentation would need to state clearly that returned object contains ASOC data so can cause autosave, etc. to fail)


TO DO:

-- not convinced this module is justified: the conversion options for dates and numbers could be folded into those modules' existing `convert...` handlers; the `convert [object] to text` could go into TextLib; the JSON stuff into WebLib (Q. what about Base64 conversion?); another possibility would be to move everything into Parsing and Formatting Text suite in TextLib

- add optional parameter to `format number` for specifying decimal places and padding? these are common tasks, so accept e.g. a record containing one or more of: decimal places, minimum decimal places, rounding method, minimum integral places

- should `convert text to date/number` in DateLib and NumberLib be folded into `parse date/number` etc as the default behavior when no other is specified? or should parse/format use current locale by default, in which case they need to be kept separate? (another possibility would be to rework as `canonical date/number/text` commands)


- note that `format object` is problematic to implement for some types, as it'll require an AE handler-based implementation to convert some types (e.g. records, references) as ASOC can't convert script objects to NSAppleEventDescriptors, so there's no way to call OSAKit directly (FWIW, writing a script object to temp file via `store script` and reading that into OSALanguage would probably work, but would be slow and humiliatingly hacky); a custom OSAX/event handler wouldn't need to do much: just take a script object (which `format object` would create as a portable wrapper for theData), execute it (the script would just return a value), and get source code (and/or human-readable representation) of the result

- not sure about formatting type class and symbol constants (IIRC, AS only binds application info to reference objects, not type/constant objects, in which case only terms defined in AS's own dictionary will format as keywords and the rest will format using raw chevron syntax unless the appropriate app's terminology is forcibly loaded into AS interpreter at runtime (e.g. using `run script` trickery, or when running scripts in SE)


- make sure NSDateFormatter and NSNumberFormatter never use their own global defaults, as a host process may have customized those itself; always set new instance's attributes to known values


- what, if any, localization info (via NSLocale) might be relevant/useful to AS users?


- what about NSByteCountFormatter, NSDateComponentsFormatter, NSDateIntervalFormatter, NSEnergyFormatter, NSMassFormatter, NSLengthFormatter, MKDistanceFormatter?

     � 	 	    F o r m a t L i b   - -   p a r s e   a n d   f o r m a t   A p p l e S c r i p t   v a l u e s 
 
 N o t e s : 
 
 -   N S N u m b e r F o r m a t t e r s ,   N S D a t e F o r m a t t e r s ,   e t c .   ( l i k e   a l l   o t h e r   A S O C   o b j e c t s )   s h o u l d n ' t   b e   r e t a i n e d   i n   l i b r a r y   ( o r   s c r i p t   o b j e c t s   r e t u r n e d   b y   i t )   a s   t h a t   b r e a k s   s t o r e   s c r i p t / s a v e / a u t o s a v e   ( c a v e a t :   i f   t h e r e   i s   a   s i g n i f i c a n t   p e r f o r m a n c e   d i f f e r e n c e   b e t w e e n   c r e a t i n g   a   f o r m a t t e r   o n c e   a n d   r e u s i n g   i t   v s   c r e a t i n g   i t   e a c h   t i m e ,   D a t e F o r m a t t e r O b j e c t s   c o u l d   b e   r e t u r n e d   a s   a n   _ a l t e r n a t i v e _   t o   u s i n g   ` p a r s e   d a t e ` / ` f o r m a t   d a t e `   h a n d l e r s   w h e r e   u s e r   r e a l l y   n e e d s   t h e   e x t r a   s p e e d ;   h o w e v e r ,   d o c u m e n t a t i o n   w o u l d   n e e d   t o   s t a t e   c l e a r l y   t h a t   r e t u r n e d   o b j e c t   c o n t a i n s   A S O C   d a t a   s o   c a n   c a u s e   a u t o s a v e ,   e t c .   t o   f a i l ) 
 
 
 T O   D O : 
 
 - -   n o t   c o n v i n c e d   t h i s   m o d u l e   i s   j u s t i f i e d :   t h e   c o n v e r s i o n   o p t i o n s   f o r   d a t e s   a n d   n u m b e r s   c o u l d   b e   f o l d e d   i n t o   t h o s e   m o d u l e s '   e x i s t i n g   ` c o n v e r t . . . `   h a n d l e r s ;   t h e   ` c o n v e r t   [ o b j e c t ]   t o   t e x t `   c o u l d   g o   i n t o   T e x t L i b ;   t h e   J S O N   s t u f f   i n t o   W e b L i b   ( Q .   w h a t   a b o u t   B a s e 6 4   c o n v e r s i o n ? ) ;   a n o t h e r   p o s s i b i l i t y   w o u l d   b e   t o   m o v e   e v e r y t h i n g   i n t o   P a r s i n g   a n d   F o r m a t t i n g   T e x t   s u i t e   i n   T e x t L i b 
 
 -   a d d   o p t i o n a l   p a r a m e t e r   t o   ` f o r m a t   n u m b e r `   f o r   s p e c i f y i n g   d e c i m a l   p l a c e s   a n d   p a d d i n g ?   t h e s e   a r e   c o m m o n   t a s k s ,   s o   a c c e p t   e . g .   a   r e c o r d   c o n t a i n i n g   o n e   o r   m o r e   o f :   d e c i m a l   p l a c e s ,   m i n i m u m   d e c i m a l   p l a c e s ,   r o u n d i n g   m e t h o d ,   m i n i m u m   i n t e g r a l   p l a c e s 
 
 -   s h o u l d   ` c o n v e r t   t e x t   t o   d a t e / n u m b e r `   i n   D a t e L i b   a n d   N u m b e r L i b   b e   f o l d e d   i n t o   ` p a r s e   d a t e / n u m b e r `   e t c   a s   t h e   d e f a u l t   b e h a v i o r   w h e n   n o   o t h e r   i s   s p e c i f i e d ?   o r   s h o u l d   p a r s e / f o r m a t   u s e   c u r r e n t   l o c a l e   b y   d e f a u l t ,   i n   w h i c h   c a s e   t h e y   n e e d   t o   b e   k e p t   s e p a r a t e ?   ( a n o t h e r   p o s s i b i l i t y   w o u l d   b e   t o   r e w o r k   a s   ` c a n o n i c a l   d a t e / n u m b e r / t e x t `   c o m m a n d s ) 
 
 
 -   n o t e   t h a t   ` f o r m a t   o b j e c t `   i s   p r o b l e m a t i c   t o   i m p l e m e n t   f o r   s o m e   t y p e s ,   a s   i t ' l l   r e q u i r e   a n   A E   h a n d l e r - b a s e d   i m p l e m e n t a t i o n   t o   c o n v e r t   s o m e   t y p e s   ( e . g .   r e c o r d s ,   r e f e r e n c e s )   a s   A S O C   c a n ' t   c o n v e r t   s c r i p t   o b j e c t s   t o   N S A p p l e E v e n t D e s c r i p t o r s ,   s o   t h e r e ' s   n o   w a y   t o   c a l l   O S A K i t   d i r e c t l y   ( F W I W ,   w r i t i n g   a   s c r i p t   o b j e c t   t o   t e m p   f i l e   v i a   ` s t o r e   s c r i p t `   a n d   r e a d i n g   t h a t   i n t o   O S A L a n g u a g e   w o u l d   p r o b a b l y   w o r k ,   b u t   w o u l d   b e   s l o w   a n d   h u m i l i a t i n g l y   h a c k y ) ;   a   c u s t o m   O S A X / e v e n t   h a n d l e r   w o u l d n ' t   n e e d   t o   d o   m u c h :   j u s t   t a k e   a   s c r i p t   o b j e c t   ( w h i c h   ` f o r m a t   o b j e c t `   w o u l d   c r e a t e   a s   a   p o r t a b l e   w r a p p e r   f o r   t h e D a t a ) ,   e x e c u t e   i t   ( t h e   s c r i p t   w o u l d   j u s t   r e t u r n   a   v a l u e ) ,   a n d   g e t   s o u r c e   c o d e   ( a n d / o r   h u m a n - r e a d a b l e   r e p r e s e n t a t i o n )   o f   t h e   r e s u l t 
 
 -   n o t   s u r e   a b o u t   f o r m a t t i n g   t y p e   c l a s s   a n d   s y m b o l   c o n s t a n t s   ( I I R C ,   A S   o n l y   b i n d s   a p p l i c a t i o n   i n f o   t o   r e f e r e n c e   o b j e c t s ,   n o t   t y p e / c o n s t a n t   o b j e c t s ,   i n   w h i c h   c a s e   o n l y   t e r m s   d e f i n e d   i n   A S ' s   o w n   d i c t i o n a r y   w i l l   f o r m a t   a s   k e y w o r d s   a n d   t h e   r e s t   w i l l   f o r m a t   u s i n g   r a w   c h e v r o n   s y n t a x   u n l e s s   t h e   a p p r o p r i a t e   a p p ' s   t e r m i n o l o g y   i s   f o r c i b l y   l o a d e d   i n t o   A S   i n t e r p r e t e r   a t   r u n t i m e   ( e . g .   u s i n g   ` r u n   s c r i p t `   t r i c k e r y ,   o r   w h e n   r u n n i n g   s c r i p t s   i n   S E ) 
 
 
 -   m a k e   s u r e   N S D a t e F o r m a t t e r   a n d   N S N u m b e r F o r m a t t e r   n e v e r   u s e   t h e i r   o w n   g l o b a l   d e f a u l t s ,   a s   a   h o s t   p r o c e s s   m a y   h a v e   c u s t o m i z e d   t h o s e   i t s e l f ;   a l w a y s   s e t   n e w   i n s t a n c e ' s   a t t r i b u t e s   t o   k n o w n   v a l u e s 
 
 
 -   w h a t ,   i f   a n y ,   l o c a l i z a t i o n   i n f o   ( v i a   N S L o c a l e )   m i g h t   b e   r e l e v a n t / u s e f u l   t o   A S   u s e r s ? 
 
 
 -   w h a t   a b o u t   N S B y t e C o u n t F o r m a t t e r ,   N S D a t e C o m p o n e n t s F o r m a t t e r ,   N S D a t e I n t e r v a l F o r m a t t e r ,   N S E n e r g y F o r m a t t e r ,   N S M a s s F o r m a t t e r ,   N S L e n g t h F o r m a t t e r ,   M K D i s t a n c e F o r m a t t e r ? 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �      s u p p o r t     !   l     ��������  ��  ��   !  " # " l      $ % & $ j    �� '�� 0 _supportlib _supportLib ' N     ( ( 4    �� )
�� 
scpt ) m     * * � + + " L i b r a r y S u p p o r t L i b % "  used for parameter checking    & � , , 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g #  - . - l     ��������  ��  ��   .  / 0 / l     ��������  ��  ��   0  1 2 1 i    3 4 3 I      �� 5���� 
0 _error   5  6 7 6 o      ���� 0 handlername handlerName 7  8 9 8 o      ���� 0 etext eText 9  : ; : o      ���� 0 enumber eNumber ;  < = < o      ���� 0 efrom eFrom =  >�� > o      ���� 
0 eto eTo��  ��   4 n     ? @ ? I    �� A���� &0 throwcommanderror throwCommandError A  B C B m     D D � E E  F o r m a t L i b C  F G F o    ���� 0 handlername handlerName G  H I H o    ���� 0 etext eText I  J K J o    	���� 0 enumber eNumber K  L M L o   	 
���� 0 efrom eFrom M  N�� N o   
 ���� 
0 eto eTo��  ��   @ o     ���� 0 _supportlib _supportLib 2  O P O l     ��������  ��  ��   P  Q R Q l     ��������  ��  ��   R  S T S l     �� U V��   U J D--------------------------------------------------------------------    V � W W � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - T  X Y X l     �� Z [��   Z   locale support    [ � \ \    l o c a l e   s u p p o r t Y  ] ^ ] l     ��������  ��  ��   ^  _ ` _ i    a b a I      �� c����  0 _localeforcode _localeForCode c  d�� d o      ���� 0 
localecode 
localeCode��  ��   b k     	 e e  f g f l     �� h i��   h ( " TO DO: error if unrecognized code    i � j j D   T O   D O :   e r r o r   i f   u n r e c o g n i z e d   c o d e g  k�� k L     	 l l n     m n m I    �� o���� :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_ o  p�� p o    ���� 0 
localecode 
localeCode��  ��   n n     q r q o    ���� 0 nslocale NSLocale r m     ��
�� misccura��   `  s t s l     ��������  ��  ��   t  u v u l     �� w x��   w  -----    x � y y 
 - - - - - v  z { z l     ��������  ��  ��   {  | } | i    ~  ~ I     ������
�� .Fmt:LLocnull��� ��� null��  ��    l     � � � � L      � � c      � � � l     ����� � n     � � � I    �� ����� 60 sortedarrayusingselector_ sortedArrayUsingSelector_ �  ��� � m     � � � � �  c o m p a r e :��  ��   � n     � � � I    �������� 80 availablelocaleidentifiers availableLocaleIdentifiers��  ��   � n     � � � o    ���� 0 nslocale NSLocale � m     ��
�� misccura��  ��   � m    ��
�� 
list � , &> {"af", "af_NA", "af_ZA", "agq", ...}    � � � � L >   { " a f " ,   " a f _ N A " ,   " a f _ Z A " ,   " a g q " ,   . . . } }  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   � J D--------------------------------------------------------------------    � � � � � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - �  � � � l     �� � ���   �   numbers    � � � �    n u m b e r s �  � � � l     ��������  ��  ��   �  � � � i   ! � � � I      �� ����� ,0 _makenumberformatter _makeNumberFormatter �  � � � o      ���� 0 formatstyle formatStyle �  ��� � o      ���� 0 
localecode 
localeCode��  ��   � k     � � �  � � � r      � � � n     � � � I    �������� 0 init  ��  ��   � n     � � � I    �������� 	0 alloc  ��  ��   � n     � � � o    ���� &0 nsnumberformatter NSNumberFormatter � m     ��
�� misccura � o      ���� 0 theformatter theFormatter �  � � � Z    � � � � � � =    � � � o    ���� 0 formatstyle formatStyle � m    ��
�� FNStFNS0 � n    � � � I    �� ����� "0 setnumberstyle_ setNumberStyle_ �  ��� � l    ����� � n    � � � o    ���� 40 nsnumberformatternostyle NSNumberFormatterNoStyle � m    ��
�� misccura��  ��  ��  ��   � o    ���� 0 theformatter theFormatter �  � � � =   " � � � o     ���� 0 formatstyle formatStyle � m     !��
�� FNStFNS1 �  � � � l  % - � � � � n  % - � � � I   & -�� ����� "0 setnumberstyle_ setNumberStyle_ �  ��� � l  & ) ���~ � n  & ) � � � o   ' )�}�} >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle � m   & '�|
�| misccura�  �~  ��  ��   � o   % &�{�{ 0 theformatter theFormatter � - ' uses thousands separators, no exponent    � � � � N   u s e s   t h o u s a n d s   s e p a r a t o r s ,   n o   e x p o n e n t �  � � � =  0 3 � � � o   0 1�z�z 0 formatstyle formatStyle � m   1 2�y
�y FNStFNS2 �  � � � l  6 > � � � � n  6 > � � � I   7 >�x ��w�x "0 setnumberstyle_ setNumberStyle_ �  ��v � l  7 : ��u�t � n  7 : � � � o   8 :�s�s @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle � m   7 8�r
�r misccura�u  �t  �v  �w   � o   6 7�q�q 0 theformatter theFormatter �   adds currency symbol    � � � � *   a d d s   c u r r e n c y   s y m b o l �  � � � =  A D � � � o   A B�p�p 0 formatstyle formatStyle � m   B C�o
�o FNStFNS3 �  � � � l  G O � � � � n  G O � � � I   H O�n ��m�n "0 setnumberstyle_ setNumberStyle_ �  ��l � l  H K ��k�j � n  H K � � � o   I K�i�i >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle � m   H I�h
�h misccura�k  �j  �l  �m   � o   G H�g�g 0 theformatter theFormatter � ( " multiplies by 100 and appends '%'    � � � � D   m u l t i p l i e s   b y   1 0 0   a n d   a p p e n d s   ' % ' �  � � � =  R U � � � o   R S�f�f 0 formatstyle formatStyle � m   S T�e
�e FNStFNS4 �  � � � n  X ` � � � I   Y `�d ��c�d "0 setnumberstyle_ setNumberStyle_ �  �b  l  Y \�a�` n  Y \ o   Z \�_�_ D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle m   Y Z�^
�^ misccura�a  �`  �b  �c   � o   X Y�]�] 0 theformatter theFormatter �  =  c f o   c d�\�\ 0 formatstyle formatStyle m   d e�[
�[ FNStFNS5 �Z l  i s	
	 n  i s I   j s�Y�X�Y "0 setnumberstyle_ setNumberStyle_ �W l  j o�V�U n  j o o   k o�T�T @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle m   j k�S
�S misccura�V  �U  �W  �X   o   i j�R�R 0 theformatter theFormatter
  	 as words    �    a s   w o r d s�Z   � R   v ��Q
�Q .ascrerr ****      � **** m   � � � b I n v a l i d    i n    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) . �P
�P 
errn m   z }�O�O�Y �N
�N 
erob o   � ��M�M 0 formatstyle formatStyle �L�K
�L 
errt m   � ��J
�J 
enum�K   �  Z   � � �I�H >  � �!"! o   � ��G�G 0 
localecode 
localeCode" m   � ��F
�F 
msng  l  � �#$%# n  � �&'& I   � ��E(�D�E 0 
setlocale_ 
setLocale_( )�C) I   � ��B*�A�B  0 _localeforcode _localeForCode* +�@+ n  � �,-, I   � ��?.�>�? "0 astextparameter asTextParameter. /0/ o   � ��=�= 0 
localecode 
localeCode0 1�<1 m   � �22 �33  f o r   l o c a l e�<  �>  - o   � ��;�; 0 _supportlib _supportLib�@  �A  �C  �D  ' o   � ��:�: 0 theformatter theFormatter$ | v TO DO: need to set default locale if not specified, in case host process has previously customized formatter defaults   % �44 �   T O   D O :   n e e d   t o   s e t   d e f a u l t   l o c a l e   i f   n o t   s p e c i f i e d ,   i n   c a s e   h o s t   p r o c e s s   h a s   p r e v i o u s l y   c u s t o m i z e d   f o r m a t t e r   d e f a u l t s�I  �H   5�95 L   � �66 o   � ��8�8 0 theformatter theFormatter�9   � 787 l     �7�6�5�7  �6  �5  8 9:9 l     �4�3�2�4  �3  �2  : ;<; l     �1�0�/�1  �0  �/  < =>= i  " %?@? I     �.AB
�. .Fmt:FNumnull���     nmbrA o      �-�- 0 	thenumber 	theNumberB �,CD
�, 
UsinC |�+�*E�)F�+  �*  E o      �(�( 0 formatstyle formatStyle�)  F l     G�'�&G m      �%
�% FNStFNS0�'  �&  D �$H�#
�$ 
LocaH |�"�!I� J�"  �!  I o      �� 0 
localecode 
localeCode�   J l     K��K m      �
� 
msng�  �  �#  @ l    MLMNL Q     MOPQO k    ;RR STS r    UVU n   WXW I    �Y�� &0 asnumberparameter asNumberParameterY Z[Z o    	�� 0 	thenumber 	theNumber[ \�\ m   	 
]] �^^  �  �  X o    �� 0 _supportlib _supportLibV o      �� 0 	thenumber 	theNumberT _`_ r    aba I    �c�� ,0 _makenumberformatter _makeNumberFormatterc ded o    �� 0 formatstyle formatStylee f�f o    �� 0 
localecode 
localeCode�  �  b o      �� 0 theformatter theFormatter` ghg r    #iji n   !klk I    !�m�� &0 stringfromnumber_ stringFromNumber_m n�n o    �� 0 	thenumber 	theNumber�  �  l o    �� 0 theformatter theFormatterj o      �
�
 0 
asocstring 
asocStringh opo l  $ 6qrsq Z  $ 6tu�	�t =  $ 'vwv o   $ %�� 0 
asocstring 
asocStringw m   % &�
� 
msngu R   * 2�xy
� .ascrerr ****      � ****x m   0 1zz �{{ $ A n   e r r o r   o c c u r r e d .y �|}
� 
errn| m   , -���Y} �~�
� 
erob~ o   . /� �  0 	thenumber 	theNumber�  �	  �  r n h shouldn't fail, but -stringFromNumber:'s return type isn't declared as non-nullable so check to be sure   s � �   s h o u l d n ' t   f a i l ,   b u t   - s t r i n g F r o m N u m b e r : ' s   r e t u r n   t y p e   i s n ' t   d e c l a r e d   a s   n o n - n u l l a b l e   s o   c h e c k   t o   b e   s u r ep ���� L   7 ;�� c   7 :��� o   7 8���� 0 
asocstring 
asocString� m   8 9��
�� 
ctxt��  P R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  Q I   C M������� 
0 _error  � ��� m   D E�� ���  f o r m a t   n u m b e r� ��� o   E F���� 0 etext eText� ��� o   F G���� 0 enumber eNumber� ��� o   G H���� 0 efrom eFrom� ���� o   H I���� 
0 eto eTo��  ��  M ; 5 TO DO: optional param for specifying places, padding   N ��� j   T O   D O :   o p t i o n a l   p a r a m   f o r   s p e c i f y i n g   p l a c e s ,   p a d d i n g> ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  & )��� I     ����
�� .Fmt:PNumnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Usin� |����������  ��  � o      ���� 0 formatstyle formatStyle��  � l     ������ m      ��
�� FNStFNS0��  ��  � �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q     M���� k    ;�� ��� r    ��� n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    	���� 0 thetext theText� ���� m   	 
�� ���  ��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 thetext theText� ��� r    ��� I    ������� ,0 _makenumberformatter _makeNumberFormatter� ��� o    ���� 0 formatstyle formatStyle� ���� o    ���� 0 
localecode 
localeCode��  ��  � o      ���� 0 theformatter theFormatter� ��� r    #��� n   !��� I    !������� &0 numberfromstring_ numberFromString_� ���� o    ���� 0 thetext theText��  ��  � o    ���� 0 theformatter theFormatter� o      ���� 0 
asocnumber 
asocNumber� ��� l  $ 6���� Z  $ 6������� =  $ '��� o   $ %���� 0 
asocnumber 
asocNumber� m   % &��
�� 
msng� R   * 2����
�� .ascrerr ****      � ****� m   0 1�� ��� j T e x t   d o e s n ' t   c o n t a i n   a   n u m b e r   i n   t h e   r e q u i r e d   f o r m a t .� ����
�� 
errn� m   , -�����Y� �����
�� 
erob� o   . /���� 0 thetext theText��  ��  ��  � k e TO DO: include formatStyle and localeCode in error message? (Q. how forgiving is NSNumberFormatter?)   � ��� �   T O   D O :   i n c l u d e   f o r m a t S t y l e   a n d   l o c a l e C o d e   i n   e r r o r   m e s s a g e ?   ( Q .   h o w   f o r g i v i n g   i s   N S N u m b e r F o r m a t t e r ? )� ���� L   7 ;�� c   7 :��� o   7 8���� 0 
asocnumber 
asocNumber� m   8 9��
�� 
****��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � I   C M������� 
0 _error  � ��� m   D E�� ���  p a r s e   n u m b e r� ��� o   E F���� 0 etext eText� ��� o   F G���� 0 enumber eNumber� ��� o   G H���� 0 efrom eFrom� ���� o   H I���� 
0 eto eTo��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   dates   � �      d a t e s�  l     ��������  ��  ��    l     ����   D > TO DO: defaults? ISO8601? (confirm locale never affects this)    � |   T O   D O :   d e f a u l t s ?   I S O 8 6 0 1 ?   ( c o n f i r m   l o c a l e   n e v e r   a f f e c t s   t h i s ) 	 l     ��������  ��  ��  	 

 i  * - I      ������ 0 
_datestyle 
_dateStyle  o      ���� 0 	theformat 	theFormat �� o      ���� 0 formatstyles formatStyles��  ��   k     �  X     u�� k   I p  r   I ` o   I J���� 0 aref aRef J        o      ���� 0 
formattype 
formatType   o      ���� 0 isdate isDate  !��! o      ���� 0 
asocoption 
asocOption��   "��" Z  a p#$����# =  a d%&% o   a b���� 0 	theformat 	theFormat& o   b c���� 0 
formattype 
formatType$ L   g l'' J   g k(( )*) o   g h���� 0 isdate isDate* +��+ o   h i���� 0 
asocoption 
asocOption��  ��  ��  ��  �� 0 aref aRef J    =,, -.- l 	  
/����/ J    
00 121 m    ��
�� FDStFDS12 343 m    �
� boovtrue4 5�~5 n   676 o    �}�} 60 nsdateformattershortstyle NSDateFormatterShortStyle7 m    �|
�| misccura�~  ��  ��  . 898 l 	 
 :�{�z: J   
 ;; <=< m   
 �y
�y FDStFDS2= >?> m    �x
�x boovtrue? @�w@ n   ABA o    �v�v 80 nsdateformattermediumstyle NSDateFormatterMediumStyleB m    �u
�u misccura�w  �{  �z  9 CDC l 	  E�t�sE J    FF GHG m    �r
�r FDStFDS3H IJI m    �q
�q boovtrueJ K�pK n   LML o    �o�o 40 nsdateformatterlongstyle NSDateFormatterLongStyleM m    �n
�n misccura�p  �t  �s  D NON l 	  P�m�lP J    QQ RSR m    �k
�k FDStFDS4S TUT m    �j
�j boovtrueU V�iV n   WXW o    �h�h 40 nsdateformatterfullstyle NSDateFormatterFullStyleX m    �g
�g misccura�i  �m  �l  O YZY l 	  &[�f�e[ J    &\\ ]^] m     �d
�d FDStFDS6^ _`_ m     !�c
�c boovfals` a�ba n  ! $bcb o   " $�a�a 60 nsdateformattershortstyle NSDateFormatterShortStylec m   ! "�`
�` misccura�b  �f  �e  Z ded l 	 & -f�_�^f J   & -gg hih m   & '�]
�] FDStFDS7i jkj m   ' (�\
�\ boovfalsk l�[l n  ( +mnm o   ) +�Z�Z 80 nsdateformattermediumstyle NSDateFormatterMediumStylen m   ( )�Y
�Y misccura�[  �_  �^  e opo l 	 - 4q�X�Wq J   - 4rr sts m   - .�V
�V FDStFDS8t uvu m   . /�U
�U boovfalsv w�Tw n  / 2xyx o   0 2�S�S 40 nsdateformatterlongstyle NSDateFormatterLongStyley m   / 0�R
�R misccura�T  �X  �W  p z�Qz l 	 4 ;{�P�O{ J   4 ;|| }~} m   4 5�N
�N FDStFDS9~ � m   5 6�M
�M boovfals� ��L� n  6 9��� o   7 9�K�K 40 nsdateformatterfullstyle NSDateFormatterFullStyle� m   6 7�J
�J misccura�L  �P  �O  �Q   ��I� R   v ��H��
�H .ascrerr ****      � ****� m   � ��� ��� h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .� �G��
�G 
errn� m   z }�F�F�Y� �E��
�E 
erob� o   � ��D�D 0 formatstyles formatStyles� �C��B
�C 
errt� m   � ��A
�A 
enum�B  �I   ��� l     �@�?�>�@  �?  �>  � ��� l     �=�<�;�=  �<  �;  � ��� i  . 1��� I      �:��9�: (0 _makedateformatter _makeDateFormatter� ��� o      �8�8 0 	theformat 	theFormat� ��7� o      �6�6 0 
localecode 
localeCode�7  �9  � k     ��� ��� r     ��� n    ��� I    �5�4�3�5 0 init  �4  �3  � n    ��� I    �2�1�0�2 	0 alloc  �1  �0  � n    ��� o    �/�/ "0 nsdateformatter NSDateFormatter� m     �.
�. misccura� o      �-�- 0 theformatter theFormatter� ��� Z    ����,�� =    ��� l   ��+�*� I   �)��
�) .corecnte****       ****� J    �� ��(� o    �'�' 0 	theformat 	theFormat�(  � �&��%
�& 
kocl� m    �$
�$ 
ctxt�%  �+  �*  � m    �#�#  � l   x���� k    x�� ��� n   $��� I    $�"��!�" 0 setdatestyle_ setDateStyle_� �� � l    ���� n    ��� o     �� 00 nsdateformatternostyle NSDateFormatterNoStyle� m    �
� misccura�  �  �   �!  � o    �� 0 theformatter theFormatter� ��� n  % -��� I   & -���� 0 settimestyle_ setTimeStyle_� ��� l  & )���� n  & )��� o   ' )�� 00 nsdateformatternostyle NSDateFormatterNoStyle� m   & '�
� misccura�  �  �  �  � o   % &�� 0 theformatter theFormatter� ��� X   . x���� k   G s�� ��� r   G _��� I      ���� 0 
_datestyle 
_dateStyle� ��� n  H K��� 1   I K�
� 
pcnt� o   H I�� 0 aref aRef� ��� o   K L�� 0 	theformat 	theFormat�  �  � J      �� ��� o      �
�
 0 isdate isDate� ��	� o      �� 0 
asocoption 
asocOption�	  � ��� Z   ` s����� o   ` a�� 0 isdate isDate� l  d j���� n  d j��� I   e j���� 0 setdatestyle_ setDateStyle_� �� � o   e f���� 0 
asocoption 
asocOption�   �  � o   d e���� 0 theformatter theFormatter�  �  �  � l  m s������ n  m s��� I   n s������� 0 settimestyle_ setTimeStyle_� ���� o   n o���� 0 
asocoption 
asocOption��  ��  � o   m n���� 0 theformatter theFormatter��  ��  �  � 0 aref aRef� n  1 ;��� I   6 ;������� "0 aslistparameter asListParameter� ���� o   6 7���� 0 	theformat 	theFormat��  ��  � o   1 6���� 0 _supportlib _supportLib�  � < 6 use predefined date-style and/or time-style constants   � ��� l   u s e   p r e d e f i n e d   d a t e - s t y l e   a n d / o r   t i m e - s t y l e   c o n s t a n t s�,  � l  { ����� n  { ���� I   | ��������  0 setdateformat_ setDateFormat_� ���� l  | ������� n  | ���� I   � �������� "0 astextparameter asTextParameter� ��� o   � ����� 0 	theformat 	theFormat� ���� m   � ��� ��� 
 u s i n g��  ��  � o   | ����� 0 _supportlib _supportLib��  ��  ��  ��  � o   { |���� 0 theformatter theFormatter�   use custom format string   � ��� 2   u s e   c u s t o m   f o r m a t   s t r i n g� ��� Z   � � ����  >  � � o   � ����� 0 
localecode 
localeCode m   � ���
�� 
msng l  � � n  � � I   � ���	���� 0 
setlocale_ 
setLocale_	 
��
 I   � �������  0 _localeforcode _localeForCode �� n  � � I   � ������� "0 astextparameter asTextParameter  o   � ����� 0 
localecode 
localeCode �� m   � � �  f o r   l o c a l e��  ��   o   � ����� 0 _supportlib _supportLib��  ��  ��  ��   o   � ����� 0 theformatter theFormatter | v TO DO: need to set default locale if not specified, in case host process has previously customized formatter defaults    � �   T O   D O :   n e e d   t o   s e t   d e f a u l t   l o c a l e   i f   n o t   s p e c i f i e d ,   i n   c a s e   h o s t   p r o c e s s   h a s   p r e v i o u s l y   c u s t o m i z e d   f o r m a t t e r   d e f a u l t s��  ��  � �� L   � � o   � ����� 0 theformatter theFormatter��  �  l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��    l     ����  I    ��!"
�� .Fmt:FDatnull���     ldt ! l    #����# m     $$ ldt     �`����  ��  " ��%��
�� 
Usin% m    ��
�� FDStFDS8��  ��  ��   &'& l     ��������  ��  ��  ' ()( i  2 5*+* I     ��,-
�� .Fmt:FDatnull���     ldt , o      ���� 0 thedate theDate- ��./
�� 
Usin. |����0��1��  ��  0 o      ���� 0 	theformat 	theFormat��  1 l     2����2 J      33 4��4 m      ��
�� FDStFDS1��  ��  ��  / ��5��
�� 
Loca5 |����6��7��  ��  6 o      ���� 0 
localecode 
localeCode��  7 l     8����8 m      ��
�� 
msng��  ��  ��  + Q     69:;9 k    $<< =>= r    ?@? n   ABA I    ��C���� "0 asdateparameter asDateParameterC DED o    	���� 0 thedate theDateE F��F m   	 
GG �HH  ��  ��  B o    ���� 0 _supportlib _supportLib@ o      ���� 0 thedate theDate> IJI r    KLK I    ��M���� (0 _makedateformatter _makeDateFormatterM NON o    ���� 0 	theformat 	theFormatO P��P o    ���� 0 
localecode 
localeCode��  ��  L o      ���� 0 theformatter theFormatterJ Q��Q L    $RR c    #STS l   !U����U n   !VWV I    !��X���� "0 stringfromdate_ stringFromDate_X Y��Y o    ���� 0 thedate theDate��  ��  W o    ���� 0 theformatter theFormatter��  ��  T m   ! "��
�� 
ctxt��  : R      ��Z[
�� .ascrerr ****      � ****Z o      ���� 0 etext eText[ ��\]
�� 
errn\ o      ���� 0 enumber eNumber] ��^_
�� 
erob^ o      ���� 0 efrom eFrom_ ��`��
�� 
errt` o      ���� 
0 eto eTo��  ; I   , 6��a���� 
0 _error  a bcb m   - .dd �ee  f o r m a t   d a t ec fgf o   . /���� 0 etext eTextg hih o   / 0���� 0 enumber eNumberi jkj o   0 1���� 0 efrom eFromk l��l o   1 2���� 
0 eto eTo��  ��  ) mnm l     ��������  ��  ��  n opo l     ��������  ��  ��  p qrq i  6 9sts I     ��uv
�� .Fmt:PDatnull���     ctxtu o      ���� 0 thetext theTextv �wx
� 
Usinw |�~�}y�|z�~  �}  y o      �{�{ 0 	theformat 	theFormat�|  z l     {�z�y{ J      || }�x} m      �w
�w FDStFDS1�x  �z  �y  x �v~�u
�v 
Loca~ |�t�s�r��t  �s   o      �q�q 0 
localecode 
localeCode�r  � l     ��p�o� m      �n
�n 
msng�p  �o  �u  t Q     J���� k    8�� ��� r    ��� n   ��� I    �m��l�m "0 astextparameter asTextParameter� ��� o    	�k�k 0 thetext theText� ��j� m   	 
�� ���  �j  �l  � o    �i�i 0 _supportlib _supportLib� o      �h�h 0 thetext theText� ��� r    ��� I    �g��f�g (0 _makedateformatter _makeDateFormatter� ��� o    �e�e 0 	theformat 	theFormat� ��d� o    �c�c 0 
localecode 
localeCode�d  �f  � o      �b�b 0 theformatter theFormatter� ��� r    %��� c    #��� l   !��a�`� n   !��� I    !�_��^�_ "0 datefromstring_ dateFromString_� ��]� o    �\�\ 0 thetext theText�]  �^  � o    �[�[ 0 theformatter theFormatter�a  �`  � m   ! "�Z
�Z 
ldt � o      �Y�Y 0 thedate theDate� ��X� l  & 8���� Z  & 8���W�V� =  & )��� o   & '�U�U 0 thedate theDate� m   ' (�T
�T 
msng� R   , 4�S��
�S .ascrerr ****      � ****� m   2 3�� ��� f T e x t   d o e s n ' t   c o n t a i n   a   d a t e   i n   t h e   r e q u i r e d   f o r m a t .� �R��
�R 
errn� m   . /�Q�Q�Y� �P��O
�P 
erob� o   0 1�N�N 0 thetext theText�O  �W  �V  � A ; TO DO: include theFormat and localeCode in error message?    � ��� v   T O   D O :   i n c l u d e   t h e F o r m a t   a n d   l o c a l e C o d e   i n   e r r o r   m e s s a g e ?  �X  � R      �M��
�M .ascrerr ****      � ****� o      �L�L 0 etext eText� �K��
�K 
errn� o      �J�J 0 enumber eNumber� �I��
�I 
erob� o      �H�H 0 efrom eFrom� �G��F
�G 
errt� o      �E�E 
0 eto eTo�F  � I   @ J�D��C�D 
0 _error  � ��� m   A B�� ���  p a r s e   d a t e� ��� o   B C�B�B 0 etext eText� ��� o   C D�A�A 0 enumber eNumber� ��� o   D E�@�@ 0 efrom eFrom� ��?� o   E F�>�> 
0 eto eTo�?  �C  r ��� l     �=�<�;�=  �<  �;  � ��� l     �:�9�8�:  �9  �8  � ��� l     �7���7  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �6���6  �   JSON   � ��� 
   J S O N� ��� l     �5�4�3�5  �4  �3  � ��� i  : =��� I     �2��
�2 .Fmt:FJSNnull���     ****� o      �1�1 0 
jsonobject 
jsonObject� �0��/
�0 
PrPr� |�.�-��,��.  �-  � o      �+�+ "0 isprettyprinted isPrettyPrinted�,  � l     ��*�)� m      �(
�( boovtrue�*  �)  �/  � Q     ����� k    ��� ��� Z    ���'�� n   ��� I    �&��%�& (0 asbooleanparameter asBooleanParameter� ��� o    	�$�$ "0 isprettyprinted isPrettyPrinted� ��#� m   	 
�� ��� " e x t r a   w h i t e   s p a c e�#  �%  � o    �"�" 0 _supportlib _supportLib� r    ��� n   ��� o    �!�! 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted� m    � 
�  misccura� o      �� 0 writeoptions writeOptions�'  � r    ��� m    ��  � o      �� 0 writeoptions writeOptions� ��� Z    5����� H    &�� l   %���� n   %� � I     %��� (0 isvalidjsonobject_ isValidJSONObject_ � o     !�� 0 
jsonobject 
jsonObject�  �    n     o     �� *0 nsjsonserialization NSJSONSerialization m    �
� misccura�  �  � R   ) 1�
� .ascrerr ****      � **** m   / 0 � z C a n ' t   c o n v e r t   o b j e c t   t o   J S O N   ( f o u n d   u n s u p p o r t e d   o b j e c t   t y p e ) . �	

� 
errn	 m   + ,���Y
 ��
� 
erob o   - .�� 0 
jsonobject 
jsonObject�  �  �  �  r   6 O n  6 @ I   9 @��� F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_  o   9 :�
�
 0 
jsonobject 
jsonObject  o   : ;�	�	 0 writeoptions writeOptions � l  ; <�� m   ; <�
� 
obj �  �  �  �   n  6 9 o   7 9�� *0 nsjsonserialization NSJSONSerialization m   6 7�
� misccura J        o      �� 0 thedata theData � o      � �  0 theerror theError�     Z  P l!"����! =  P S#$# o   P Q���� 0 thedata theData$ m   Q R��
�� 
msng" R   V h��%&
�� .ascrerr ****      � ****% b   \ g'(' b   \ c)*) m   \ ]++ �,, : C a n ' t   c o n v e r t   o b j e c t   t o   J S O N (* n  ] b-.- I   ^ b�������� ,0 localizeddescription localizedDescription��  ��  . o   ] ^���� 0 theerror theError( m   c f// �00  ) .& ��12
�� 
errn1 m   X Y�����Y2 ��3��
�� 
erob3 o   Z [���� 0 
jsonobject 
jsonObject��  ��  ��    4��4 L   m �55 c   m �676 l  m �8����8 n  m �9:9 I   v ���;���� 00 initwithdata_encoding_ initWithData_encoding_; <=< o   v w���� 0 thedata theData= >��> l  w |?����? n  w |@A@ o   x |���� ,0 nsutf8stringencoding NSUTF8StringEncodingA m   w x��
�� misccura��  ��  ��  ��  : n  m vBCB I   r v�������� 	0 alloc  ��  ��  C n  m rDED o   n r���� 0 nsstring NSStringE m   m n��
�� misccura��  ��  7 m   � ���
�� 
ctxt��  � R      ��FG
�� .ascrerr ****      � ****F o      ���� 0 etext eTextG ��HI
�� 
errnH o      ���� 0 enumber eNumberI ��JK
�� 
erobJ o      ���� 0 efrom eFromK ��L��
�� 
errtL o      ���� 
0 eto eTo��  � I   � ���M���� 
0 _error  M NON m   � �PP �QQ  f o r m a t   J S O NO RSR o   � ����� 0 etext eTextS TUT o   � ����� 0 enumber eNumberU VWV o   � ����� 0 efrom eFromW X��X o   � ����� 
0 eto eTo��  ��  � YZY l     ��������  ��  ��  Z [\[ l     ��������  ��  ��  \ ]^] i  > A_`_ I     ��ab
�� .Fmt:PJSNnull���     ctxta o      ���� 0 jsontext jsonTextb ��c��
�� 
Fragc |����d��e��  ��  d o      ���� *0 arefragmentsallowed areFragmentsAllowed��  e l     f����f m      ��
�� boovfals��  ��  ��  ` Q     �ghig k    �jj klk r    mnm n   opo I    ��q���� "0 astextparameter asTextParameterq rsr o    	���� 0 jsontext jsonTexts t��t m   	 
uu �vv  ��  ��  p o    ���� 0 _supportlib _supportLibn o      ���� 0 jsontext jsonTextl wxw Z    *yz��{y n   |}| I    ��~���� (0 asbooleanparameter asBooleanParameter~ � o    ���� *0 arefragmentsallowed areFragmentsAllowed� ���� m    �� ��� $ a l l o w i n g   f r a g m e n t s��  ��  } o    ���� 0 _supportlib _supportLibz r    $��� n   "��� o     "���� :0 nsjsonreadingallowfragments NSJSONReadingAllowFragments� m     ��
�� misccura� o      ���� 0 readoptions readOptions��  { r   ' *��� m   ' (����  � o      ���� 0 readoptions readOptionsx ��� r   + <��� n  + :��� I   3 :������� (0 datausingencoding_ dataUsingEncoding_� ���� l  3 6������ n  3 6��� o   4 6���� ,0 nsutf8stringencoding NSUTF8StringEncoding� m   3 4��
�� misccura��  ��  ��  ��  � l  + 3������ n  + 3��� I   . 3������� &0 stringwithstring_ stringWithString_� ���� o   . /���� 0 jsontext jsonText��  ��  � n  + .��� o   , .���� 0 nsstring NSString� m   + ,��
�� misccura��  ��  � o      ���� 0 thedata theData� ��� r   = V��� n  = G��� I   @ G������� F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_� ��� o   @ A���� 0 thedata theData� ��� o   A B���� 0 readoptions readOptions� ���� l  B C������ m   B C��
�� 
obj ��  ��  ��  ��  � n  = @��� o   > @���� *0 nsjsonserialization NSJSONSerialization� m   = >��
�� misccura� J      �� ��� o      ���� 0 
jsonobject 
jsonObject� ���� o      ���� 0 theerror theError��  � ��� Z  W {������� =  W Z��� o   W X���� 0 
jsonobject 
jsonObject� m   X Y��
�� 
msng� R   ] w����
�� .ascrerr ****      � ****� b   i v��� b   i r��� m   i l�� ���   N o t   v a l i d   J S O N   (� n  l q��� I   m q�������� ,0 localizeddescription localizedDescription��  ��  � o   l m���� 0 theerror theError� m   r u�� ���  ) .� ����
�� 
errn� m   _ b�����Y� �����
�� 
erob� o   e f���� 0 jsontext jsonText��  ��  ��  � ���� L   | ��� c   | ���� o   | }���� 0 
jsonobject 
jsonObject� m   } ���
�� 
****��  h R      ����
�� .ascrerr ****      � ****� o      �� 0 etext eText� �~��
�~ 
errn� o      �}�} 0 enumber eNumber� �|��
�| 
erob� o      �{�{ 0 efrom eFrom� �z��y
�z 
errt� o      �x�x 
0 eto eTo�y  i I   � ��w��v�w 
0 _error  � ��� m   � ��� ���  p a r s e   J S O N� ��� o   � ��u�u 0 etext eText� ��� o   � ��t�t 0 enumber eNumber� ��� o   � ��s�s 0 efrom eFrom� ��r� o   � ��q�q 
0 eto eTo�r  �v  ^ ��� l     �p�o�n�p  �o  �n  � ��� l     �m�l�k�m  �l  �k  � ��� l     �j���j  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     �i���i  �   general   � ���    g e n e r a l� ��� l     �h�g�f�h  �g  �f  � ��� i  B E��� I     �e�d�
�e .Fmt:FLitnull��� ��� null�d  � �c��b
�c 
For_� o      �a�a 0 thevalue theValue�b  � l   [���� k    [�� ��� l     �`���`  ��� note that most value types can be rendered using vanilla code; only specifiers and records have to be rendered via OSA APIs; values should be rendered in human-readable form (text isn't quoted, lists are concatentated as comma-separated items, dates and numbers using default AS coercions, etc) - user can use `literal representation`, `format number/date`, etc. to format values differently (avoids need for complex template parsing)   � ���f   n o t e   t h a t   m o s t   v a l u e   t y p e s   c a n   b e   r e n d e r e d   u s i n g   v a n i l l a   c o d e ;   o n l y   s p e c i f i e r s   a n d   r e c o r d s   h a v e   t o   b e   r e n d e r e d   v i a   O S A   A P I s ;   v a l u e s   s h o u l d   b e   r e n d e r e d   i n   h u m a n - r e a d a b l e   f o r m   ( t e x t   i s n ' t   q u o t e d ,   l i s t s   a r e   c o n c a t e n t a t e d   a s   c o m m a - s e p a r a t e d   i t e m s ,   d a t e s   a n d   n u m b e r s   u s i n g   d e f a u l t   A S   c o e r c i o n s ,   e t c )   -   u s e r   c a n   u s e   ` l i t e r a l   r e p r e s e n t a t i o n ` ,   ` f o r m a t   n u m b e r / d a t e ` ,   e t c .   t o   f o r m a t   v a l u e s   d i f f e r e n t l y   ( a v o i d s   n e e d   f o r   c o m p l e x   t e m p l a t e   p a r s i n g )� ��� l     �_���_  ��� rendering arbitrary AS values requires wrapping the value in a script object (to preserve context info such as an object specifier's target application), converting that script to a typeScript descriptor (e.g. by packing it into an Apple event and sending it to a previously installed AE handler), passing that object to OSALoad and executing it to return the value as a new OSAID which can then be rendered via OSADisplay   � ���N   r e n d e r i n g   a r b i t r a r y   A S   v a l u e s   r e q u i r e s   w r a p p i n g   t h e   v a l u e   i n   a   s c r i p t   o b j e c t   ( t o   p r e s e r v e   c o n t e x t   i n f o   s u c h   a s   a n   o b j e c t   s p e c i f i e r ' s   t a r g e t   a p p l i c a t i o n ) ,   c o n v e r t i n g   t h a t   s c r i p t   t o   a   t y p e S c r i p t   d e s c r i p t o r   ( e . g .   b y   p a c k i n g   i t   i n t o   a n   A p p l e   e v e n t   a n d   s e n d i n g   i t   t o   a   p r e v i o u s l y   i n s t a l l e d   A E   h a n d l e r ) ,   p a s s i n g   t h a t   o b j e c t   t o   O S A L o a d   a n d   e x e c u t i n g   i t   t o   r e t u r n   t h e   v a l u e   a s   a   n e w   O S A I D   w h i c h   c a n   t h e n   b e   r e n d e r e d   v i a   O S A D i s p l a y� ��^� Q    [   k   E  l   �]�]   � z caution: AS types that can have overridden `class` properties (specifiers, records, etc) must be handled as special cases    � �   c a u t i o n :   A S   t y p e s   t h a t   c a n   h a v e   o v e r r i d d e n   ` c l a s s `   p r o p e r t i e s   ( s p e c i f i e r s ,   r e c o r d s ,   e t c )   m u s t   b e   h a n d l e d   a s   s p e c i a l   c a s e s 	
	 Z    ��\�[ F    > F    . F     =     l   �Z�Y I   �X
�X .corecnte****       **** J     �W o    �V�V 0 thevalue theValue�W   �U�T
�U 
kocl m    �S
�S 
obj �T  �Z  �Y   l 
  �R�Q m    �P�P  �R  �Q   =     l   �O�N I   �M 
�M .corecnte****       **** J    !! "�L" o    �K�K 0 thevalue theValue�L    �J#�I
�J 
kocl# m    �H
�H 
capp�I  �O  �N   l 
  $�G�F$ m    �E�E  �G  �F   =   ! ,%&% l  ! *'�D�C' I  ! *�B()
�B .corecnte****       ****( J   ! $** +�A+ o   ! "�@�@ 0 thevalue theValue�A  ) �?,�>
�? 
kocl, m   % &�=
�= 
reco�>  �D  �C  & l 
 * +-�<�;- m   * +�:�:  �<  �;   =   1 <./. l  1 :0�9�80 I  1 :�712
�7 .corecnte****       ****1 J   1 433 4�64 o   1 2�5�5 0 thevalue theValue�6  2 �45�3
�4 
kocl5 m   5 6�2
�2 
rdat�3  �9  �8  / m   : ;�1�1   l  A �6786 Z   A �9:;<9 >   A L=>= l  A J?�0�/? I  A J�.@A
�. .corecnte****       ****@ J   A DBB C�-C o   A B�,�, 0 thevalue theValue�-  A �+D�*
�+ 
koclD m   E F�)
�) 
scpt�*  �0  �/  > m   J K�(�(  : l  O dEFGE Q   O dHIJH L   R ZKK b   R YLML b   R WNON m   R SPP �QQ  � s c r i p t  O l  S VR�'�&R n  S VSTS 1   T V�%
�% 
pnamT o   S T�$�$ 0 thevalue theValue�'  �&  M m   W XUU �VV  �I R      �#�"�!
�# .ascrerr ****      � ****�"  �!  J L   b dWW m   b cXX �YY  � s c r i p t �FGA script objects are currently displayed as "�script[NAME]�" (displaying script objects as source code is a separate task and should be done via OSAKit/osadecompile); TO DO: support informal 'description' protocol, speculatively calling `theValue's objectDescription()` and returning result if it's a non-empty text value?   G �ZZ�   s c r i p t   o b j e c t s   a r e   c u r r e n t l y   d i s p l a y e d   a s   " � s c r i p t [ N A M E ] � "   ( d i s p l a y i n g   s c r i p t   o b j e c t s   a s   s o u r c e   c o d e   i s   a   s e p a r a t e   t a s k   a n d   s h o u l d   b e   d o n e   v i a   O S A K i t / o s a d e c o m p i l e ) ;   T O   D O :   s u p p o r t   i n f o r m a l   ' d e s c r i p t i o n '   p r o t o c o l ,   s p e c u l a t i v e l y   c a l l i n g   ` t h e V a l u e ' s   o b j e c t D e s c r i p t i o n ( ) `   a n d   r e t u r n i n g   r e s u l t   i f   i t ' s   a   n o n - e m p t y   t e x t   v a l u e ?; [\[ =  g j]^] m   g h� 
�  
pcls^ m   h i�
� 
ctxt\ _�_ k   m �`` aba r   m vcdc n  m tefe 1   p t�
� 
txdlf 1   m p�
� 
ascrd o      �� 0 oldtids oldTIDsb ghg r   w �iji m   w zkk �ll  \j n     mnm 1   } ��
� 
txdln 1   z }�
� 
ascrh opo r   � �qrq n   � �sts 2  � ��
� 
citmt o   � ��� 0 thevalue theValuer o      �� 0 	textitems 	textItemsp uvu r   � �wxw m   � �yy �zz  \ \x n     {|{ 1   � ��
� 
txdl| 1   � ��
� 
ascrv }~} r   � �� c   � ���� o   � ��� 0 	textitems 	textItems� m   � ��
� 
ctxt� o      �� 0 thevalue theValue~ ��� r   � ���� m   � ��� ���  "� n     ��� 1   � ��
� 
txdl� 1   � ��
� 
ascr� ��� r   � ���� n   � ���� 2  � ��
� 
citm� o   � ��� 0 thevalue theValue� o      �� 0 	textitems 	textItems� ��� r   � ���� m   � ��� ���  \ "� n     ��� 1   � ��
� 
txdl� 1   � ��

�
 
ascr� ��� r   � ���� c   � ���� o   � ��	�	 0 	textitems 	textItems� m   � ��
� 
ctxt� o      �� 0 thevalue theValue� ��� r   � ���� o   � ��� 0 oldtids oldTIDs� n     ��� 1   � ��
� 
txdl� 1   � ��
� 
ascr� ��� L   � ��� b   � ���� b   � ���� m   � ��� ���  "� o   � ��� 0 thevalue theValue� m   � ��� ���  "�  �  < Q   � ����� L   � ��� c   � ���� o   � ��� 0 thevalue theValue� m   � �� 
�  
ctxt� R      �����
�� .ascrerr ****      � ****��  � �����
�� 
errn� d      �� m      �������  � l  � �������  �   fall through   � ���    f a l l   t h r o u g h7 p j TO DO: should be able to format �data ...� via NSAppleEventDescriptor, avoiding need to go through OSAKit   8 ��� �   T O   D O :   s h o u l d   b e   a b l e   t o   f o r m a t   � d a t a   . . . �   v i a   N S A p p l e E v e n t D e s c r i p t o r ,   a v o i d i n g   n e e d   t o   g o   t h r o u g h   O S A K i t�\  �[  
 ��� l  � �������  � O I if it's an ASOC object specifier, use object's description, if available   � ��� �   i f   i t ' s   a n   A S O C   o b j e c t   s p e c i f i e r ,   u s e   o b j e c t ' s   d e s c r i p t i o n ,   i f   a v a i l a b l e� ��� Z   �@������� F   �
��� >   � ���� l  � ������� I  � �����
�� .corecnte****       ****� J   � ��� ���� o   � ����� 0 thevalue theValue��  � �����
�� 
kocl� m   � ���
�� 
obj ��  ��  ��  � m   � �����  � =  ���� n  ���� m   ��
�� 
want� l  � ������ c   � ��� o   � ����� 0 thevalue theValue� m   � ���
�� 
reco��  ��  � m  ��
�� 
ocid� l <���� Q  <���� L   �� b  ��� b  ��� m  �� ���  �� l ������ c  ��� n ��� I  �������� 0 description  ��  ��  � o  ���� 0 thevalue theValue� m  ��
�� 
ctxt��  ��  � m  �� ���  �� R      ������
�� .ascrerr ****      � ****��  ��  � L  (<�� b  (;��� m  (+�� ���   � c l a s s   o c i d �   i d  � l +:������ I +:�����
�� .Fmt:FLitnull��� ��� null��  � �����
�� 
For_� l /6������ n /6��� m  26��
�� 
seld� l /2������ c  /2��� o  /0���� 0 thevalue theValue� m  01��
�� 
reco��  ��  ��  ��  ��  ��  ��  � 7 1  (see TypesLib's `check type` handler for notes)   � ��� b     ( s e e   T y p e s L i b ' s   ` c h e c k   t y p e `   h a n d l e r   f o r   n o t e s )��  ��  � ��� l AA������  � � � problem here if value is a record containing ASOC specifiers, as there's no practical way to examine the record's properties without sending it to an AE handler   � ���B   p r o b l e m   h e r e   i f   v a l u e   i s   a   r e c o r d   c o n t a i n i n g   A S O C   s p e c i f i e r s ,   a s   t h e r e ' s   n o   p r a c t i c a l   w a y   t o   e x a m i n e   t h e   r e c o r d ' s   p r o p e r t i e s   w i t h o u t   s e n d i n g   i t   t o   a n   A E   h a n d l e r� ���� l AE� � L  AE m  AD �  � T O D O �  #  format value via OSAKit APIs    � :   f o r m a t   v a l u e   v i a   O S A K i t   A P I s��   R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��	
�� 
errn o      ���� 0 enumber eNumber	 ��

�� 
erob
 o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��   l M[ I  M[������ 
0 _error    m  NQ � , l i t e r a l   r e p r e s e n t a t i o n  o  QR���� 0 etext eText  o  RS���� 0 enumber eNumber  o  ST���� 0 efrom eFrom �� o  TU���� 
0 eto eTo��  ��   8 2 note: this handler should never fail, caveat bugs    � d   n o t e :   t h i s   h a n d l e r   s h o u l d   n e v e r   f a i l ,   c a v e a t   b u g s�^  � � � TO DO: how practical to include a pretty printing option? (not too hard for lists, huge pain for records) -- Q. if moving `format text` to TextLib, should this also move there or should it go in TypesLib instead?   � ��   T O   D O :   h o w   p r a c t i c a l   t o   i n c l u d e   a   p r e t t y   p r i n t i n g   o p t i o n ?   ( n o t   t o o   h a r d   f o r   l i s t s ,   h u g e   p a i n   f o r   r e c o r d s )   - -   Q .   i f   m o v i n g   ` f o r m a t   t e x t `   t o   T e x t L i b ,   s h o u l d   t h i s   a l s o   m o v e   t h e r e   o r   s h o u l d   i t   g o   i n   T y p e s L i b   i n s t e a d ?�  l     ��������  ��  ��    !  l     ��������  ��  ��  ! "#" i  F I$%$ I     ��&'
�� .Fmt:FTxtnull���     ctxt& o      ���� 0 templatetext templateText' ��(��
�� 
Usin( o      ���� 0 	thevalues 	theValues��  % k    3)) *+* l     ��,-��  , � � note: templateText uses same `$n` (where n=1-9) notation as `search text`'s replacement templates, with `\$` to escape as necessary ($ not followed by a digit will appear as-is)   - �..d   n o t e :   t e m p l a t e T e x t   u s e s   s a m e   ` $ n `   ( w h e r e   n = 1 - 9 )   n o t a t i o n   a s   ` s e a r c h   t e x t ` ' s   r e p l a c e m e n t   t e m p l a t e s ,   w i t h   ` \ $ `   t o   e s c a p e   a s   n e c e s s a r y   ( $   n o t   f o l l o w e d   b y   a   d i g i t   w i l l   a p p e a r   a s - i s )+ /��/ Q    30120 k   33 454 r    676 n   898 I    ��:���� "0 aslistparameter asListParameter: ;��; o    	���� 0 	thevalues 	theValues��  ��  9 o    ���� 0 _supportlib _supportLib7 o      ���� 0 	thevalues 	theValues5 <=< r    >?> n   @A@ I    ��B���� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_B CDC m    EE �FF  \ \ . | \ $ [ 1 - 9 ]D GHG m    ����  H I��I l   J����J m    ��
�� 
msng��  ��  ��  ��  A n   KLK o    ���� *0 nsregularexpression NSRegularExpressionL m    ��
�� misccura? o      ���� 
0 regexp  = MNM r    'OPO n   %QRQ I     %��S���� &0 stringwithstring_ stringWithString_S T��T o     !���� 0 templatetext templateText��  ��  R n    UVU o     ���� 0 nsstring NSStringV m    ��
�� misccuraP o      ���� 0 
asocstring 
asocStringN WXW r   ( 9YZY l  ( 7[����[ n  ( 7\]\ I   ) 7��^���� @0 matchesinstring_options_range_ matchesInString_options_range_^ _`_ o   ) *���� 0 
asocstring 
asocString` aba m   * +����  b c��c J   + 3dd efe m   + ,����  f g��g n  , 1hih I   - 1�������� 
0 length  ��  ��  i o   , -���� 0 
asocstring 
asocString��  ��  ��  ] o   ( )���� 
0 regexp  ��  ��  Z o      ����  0 asocmatcharray asocMatchArrayX jkj r   : >lml J   : <����  m o      ���� 0 resulttexts resultTextsk non r   ? Bpqp m   ? @����  q o      ���� 0 
startindex 
startIndexo r��r P   Cstus k   Hvv wxw Y   H �y��z{��y k   X �|| }~} r   X e� l  X c������ n  X c��� I   ^ c������� 0 rangeatindex_ rangeAtIndex_� ���� m   ^ _��  ��  ��  � l  X ^��~�}� n  X ^��� I   Y ^�|��{�|  0 objectatindex_ objectAtIndex_� ��z� o   Y Z�y�y 0 i  �z  �{  � o   X Y�x�x  0 asocmatcharray asocMatchArray�~  �}  ��  ��  � o      �w�w 0 
matchrange 
matchRange~ ��� r   f ���� c   f }��� l  f y��v�u� n  f y��� I   g y�t��s�t *0 substringwithrange_ substringWithRange_� ��r� K   g u�� �q���q 0 location  � o   h i�p�p 0 
startindex 
startIndex� �o��n�o 
0 length  � l  j q��m�l� \   j q��� l  j o��k�j� n  j o��� I   k o�i�h�g�i 0 location  �h  �g  � o   j k�f�f 0 
matchrange 
matchRange�k  �j  � o   o p�e�e 0 
startindex 
startIndex�m  �l  �n  �r  �s  � o   f g�d�d 0 
asocstring 
asocString�v  �u  � m   y |�c
�c 
ctxt� n      ���  ;   ~ � o   } ~�b�b 0 resulttexts resultTexts� ��� r   � ���� c   � ���� l  � ���a�`� n  � ���� I   � ��_��^�_ *0 substringwithrange_ substringWithRange_� ��]� o   � ��\�\ 0 
matchrange 
matchRange�]  �^  � o   � ��[�[ 0 
asocstring 
asocString�a  �`  � m   � ��Z
�Z 
ctxt� o      �Y�Y 0 thetoken theToken� ��� Z   � ����X�� =  � ���� o   � ��W�W 0 thetoken theToken� m   � ��� ���  \ \� l  � ����� r   � ���� o   � ��V�V 0 thetoken theToken� n      ���  ;   � �� o   � ��U�U 0 resulttexts resultTexts� ( " found backslash-escaped character   � ��� D   f o u n d   b a c k s l a s h - e s c a p e d   c h a r a c t e r�X  � l  � ����� k   � ��� ��� l  � ����� r   � ���� n   � ���� 4   � ��T�
�T 
cobj� l  � ���S�R� c   � ���� n  � ���� 4  � ��Q�
�Q 
cha � m   � ��P�P��� o   � ��O�O 0 thetoken theToken� m   � ��N
�N 
long�S  �R  � o   � ��M�M 0 	thevalues 	theValues� o      �L�L 0 theitem theItem� 2 , this will raise error -1728 if out of range   � ��� X   t h i s   w i l l   r a i s e   e r r o r   - 1 7 2 8   i f   o u t   o f   r a n g e� ��K� Q   � ����� r   � ���� c   � ���� o   � ��J�J 0 theitem theItem� m   � ��I
�I 
ctxt� n      ���  ;   � �� o   � ��H�H 0 resulttexts resultTexts� R      �G�F�
�G .ascrerr ****      � ****�F  � �E��D
�E 
errn� d      �� m      �C�C��D  � l  � ����� r   � ���� I  � ��B�A�
�B .Fmt:FLitnull��� ��� null�A  � �@��?
�@ 
For_� o   � ��>�> 0 theitem theItem�?  � n      ���  ;   � �� o   � ��=�= 0 resulttexts resultTexts� � � TO DO: or just throw 'unsupported object type' error, requiring user to get value's literal representation before passing it to `format text`   � ���   T O   D O :   o r   j u s t   t h r o w   ' u n s u p p o r t e d   o b j e c t   t y p e '   e r r o r ,   r e q u i r i n g   u s e r   t o   g e t   v a l u e ' s   l i t e r a l   r e p r e s e n t a t i o n   b e f o r e   p a s s i n g   i t   t o   ` f o r m a t   t e x t `�K  �  	 found $n   � ���    f o u n d   $ n� ��<� r   � ���� [   � ���� l  � ���;�:� n  � ���� I   � ��9�8�7�9 0 location  �8  �7  � o   � ��6�6 0 
matchrange 
matchRange�;  �:  � l  � ���5�4� n  � ���� I   � ��3�2�1�3 
0 length  �2  �1  � o   � ��0�0 0 
matchrange 
matchRange�5  �4  � o      �/�/ 0 
startindex 
startIndex�<  �� 0 i  z m   K L�.�.  { l  L S��-�,� \   L S��� l  L Q��+�*� n  L Q��� I   M Q�)�(�'�) 	0 count  �(  �'  � o   L M�&�&  0 asocmatcharray asocMatchArray�+  �*  � m   Q R�%�% �-  �,  ��  x ��� r   � ���� c   � �   l  � ��$�# n  � � I   � ��"�!�" *0 substringfromindex_ substringFromIndex_ �  o   � ��� 0 
startindex 
startIndex�   �!   o   � ��� 0 
asocstring 
asocString�$  �#   m   � ��
� 
ctxt� n        ;   � � o   � ��� 0 resulttexts resultTexts� 	
	 r   � � n  � � 1   � ��
� 
txdl 1   � ��
� 
ascr o      �� 0 oldtids oldTIDs
  r   � m   � � �   n      1   �
� 
txdl 1   � �
� 
ascr  r   c   o  �� 0 resulttexts resultTexts m  
�
� 
ctxt o      �� 0 
resulttext 
resultText  r    o  �� 0 oldtids oldTIDs  n     !"! 1  �
� 
txdl" 1  �
� 
ascr #�# L  $$ o  �� 0 
resulttext 
resultText�  t �%
� conscase% �&
� consdiac& �'
� conshyph' �(
� conspunc( �
�	
�
 conswhit�	  u ��
� consnume�  ��  1 R      �)*
� .ascrerr ****      � ****) o      �� 0 etext eText* �+,
� 
errn+ o      �� 0 enumber eNumber, �-.
� 
erob- o      �� 0 efrom eFrom. � /��
�  
errt/ o      ���� 
0 eto eTo��  2 I  #3��0���� 
0 _error  0 121 m  $'33 �44  f o r m a t   t e x t2 565 o  '(���� 0 etext eText6 787 o  ()���� 0 enumber eNumber8 9:9 o  )*���� 0 efrom eFrom: ;��; o  *-���� 
0 eto eTo��  ��  ��  # <=< l     ��������  ��  ��  = >��> l     ��������  ��  ��  ��       ��?@ABCDEFGHIJKLMNOP��  ? ����������������������������������
�� 
pimr�� 0 _supportlib _supportLib�� 
0 _error  ��  0 _localeforcode _localeForCode
�� .Fmt:LLocnull��� ��� null�� ,0 _makenumberformatter _makeNumberFormatter
�� .Fmt:FNumnull���     nmbr
�� .Fmt:PNumnull���     ctxt�� 0 
_datestyle 
_dateStyle�� (0 _makedateformatter _makeDateFormatter
�� .Fmt:FDatnull���     ldt 
�� .Fmt:PDatnull���     ctxt
�� .Fmt:FJSNnull���     ****
�� .Fmt:PJSNnull���     ctxt
�� .Fmt:FLitnull��� ��� null
�� .Fmt:FTxtnull���     ctxt
�� .aevtoappnull  �   � ****@ ��Q�� Q  RR ��S��
�� 
cobjS TT   �� 
�� 
frmk��  A UU   �� *
�� 
scptB �� 4����VW���� 
0 _error  �� ��X�� X  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  V ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToW  D������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+ C �� b����YZ����  0 _localeforcode _localeForCode�� ��[�� [  ���� 0 
localecode 
localeCode��  Y ���� 0 
localecode 
localeCodeZ ������
�� misccura�� 0 nslocale NSLocale�� :0 localewithlocaleidentifier_ localeWithLocaleIdentifier_�� 
��,�k+ D �� ����\]��
�� .Fmt:LLocnull��� ��� null��  ��  \  ] ������ �����
�� misccura�� 0 nslocale NSLocale�� 80 availablelocaleidentifiers availableLocaleIdentifiers�� 60 sortedarrayusingselector_ sortedArrayUsingSelector_
�� 
list�� ��,j+ �k+ �&E �� �����^_���� ,0 _makenumberformatter _makeNumberFormatter�� ��`�� `  ������ 0 formatstyle formatStyle�� 0 
localecode 
localeCode��  ^ �������� 0 formatstyle formatStyle�� 0 
localecode 
localeCode�� 0 theformatter theFormatter_ ������������������������������������������������2������
�� misccura�� &0 nsnumberformatter NSNumberFormatter�� 	0 alloc  �� 0 init  
�� FNStFNS0�� 40 nsnumberformatternostyle NSNumberFormatterNoStyle�� "0 setnumberstyle_ setNumberStyle_
�� FNStFNS1�� >0 nsnumberformatterdecimalstyle NSNumberFormatterDecimalStyle
�� FNStFNS2�� @0 nsnumberformattercurrencystyle NSNumberFormatterCurrencyStyle
�� FNStFNS3�� >0 nsnumberformatterpercentstyle NSNumberFormatterPercentStyle
�� FNStFNS4�� D0  nsnumberformatterscientificstyle  NSNumberFormatterScientificStyle
�� FNStFNS5�� @0 nsnumberformatterspelloutstyle NSNumberFormatterSpellOutStyle
�� 
errn���Y
�� 
erob
�� 
errt
�� 
enum�� 
�� 
msng�� "0 astextparameter asTextParameter��  0 _localeforcode _localeForCode�� 0 
setlocale_ 
setLocale_�� ���,j+ j+ E�O��  ���,k+ Y q��  ���,k+ Y `��  ���,k+ Y O��  ���,k+ Y >��  ���,k+ Y -��  ��a ,k+ Y )a a a �a a a a O�a  �*b  �a l+ k+ k+ Y hO�F ��@����ab��
�� .Fmt:FNumnull���     nmbr�� 0 	thenumber 	theNumber�� ��cd
�� 
Usinc {�������� 0 formatstyle formatStyle��  
�� FNStFNS0d ��e��
�� 
Locae {�������� 0 
localecode 
localeCode��  
�� 
msng��  a 	��������~�}�|�{�z�� 0 	thenumber 	theNumber�� 0 formatstyle formatStyle�� 0 
localecode 
localeCode� 0 theformatter theFormatter�~ 0 
asocstring 
asocString�} 0 etext eText�| 0 enumber eNumber�{ 0 efrom eFrom�z 
0 eto eTob ]�y�x�w�v�u�t�s�rz�q�pf��o�n�y &0 asnumberparameter asNumberParameter�x ,0 _makenumberformatter _makeNumberFormatter�w &0 stringfromnumber_ stringFromNumber_
�v 
msng
�u 
errn�t�Y
�s 
erob�r 
�q 
ctxt�p 0 etext eTextf �m�lg
�m 
errn�l 0 enumber eNumberg �k�jh
�k 
erob�j 0 efrom eFromh �i�h�g
�i 
errt�h 
0 eto eTo�g  �o �n 
0 _error  �� N =b  ��l+ E�O*��l+ E�O��k+ E�O��  )�����Y hO��&W X  *������+ G �f��e�dij�c
�f .Fmt:PNumnull���     ctxt�e 0 thetext theText�d �bkl
�b 
Usink {�a�`�_�a 0 formatstyle formatStyle�`  
�_ FNStFNS0l �^m�]
�^ 
Locam {�\�[�Z�\ 0 
localecode 
localeCode�[  
�Z 
msng�]  i 	�Y�X�W�V�U�T�S�R�Q�Y 0 thetext theText�X 0 formatstyle formatStyle�W 0 
localecode 
localeCode�V 0 theformatter theFormatter�U 0 
asocnumber 
asocNumber�T 0 etext eText�S 0 enumber eNumber�R 0 efrom eFrom�Q 
0 eto eToj ��P�O�N�M�L�K�J�I��H�Gn��F�E�P "0 astextparameter asTextParameter�O ,0 _makenumberformatter _makeNumberFormatter�N &0 numberfromstring_ numberFromString_
�M 
msng
�L 
errn�K�Y
�J 
erob�I 
�H 
****�G 0 etext eTextn �D�Co
�D 
errn�C 0 enumber eNumbero �B�Ap
�B 
erob�A 0 efrom eFromp �@�?�>
�@ 
errt�? 
0 eto eTo�>  �F �E 
0 _error  �c N =b  ��l+ E�O*��l+ E�O��k+ E�O��  )�����Y hO��&W X  *������+ H �=�<�;qr�:�= 0 
_datestyle 
_dateStyle�< �9s�9 s  �8�7�8 0 	theformat 	theFormat�7 0 formatstyles formatStyles�;  q �6�5�4�3�2�1�6 0 	theformat 	theFormat�5 0 formatstyles formatStyles�4 0 aref aRef�3 0 
formattype 
formatType�2 0 isdate isDate�1 0 
asocoption 
asocOptionr �0�/�.�-�,�+�*�)�(�'�&�%�$�#�"�!� �������
�0 FDStFDS1
�/ misccura�. 60 nsdateformattershortstyle NSDateFormatterShortStyle
�- FDStFDS2�, 80 nsdateformattermediumstyle NSDateFormatterMediumStyle
�+ FDStFDS3�* 40 nsdateformatterlongstyle NSDateFormatterLongStyle
�) FDStFDS4�( 40 nsdateformatterfullstyle NSDateFormatterFullStyle
�' FDStFDS6
�& FDStFDS7
�% FDStFDS8
�$ FDStFDS9�# 
�" 
kocl
�! 
cobj
�  .corecnte****       ****
� 
errn��Y
� 
erob
� 
errt
� 
enum� �: � t�e��,mv�e��,mv�e��,mv�e��,mv�f��,mv�f��,mv�f��,mv�f��,mv�v[��l kh �E[�k/E�Z[�l/E�Z[�m/E�ZO��  
��lvY h[OY��O)a a a �a a a a I ����tu�� (0 _makedateformatter _makeDateFormatter� �v� v  ��� 0 	theformat 	theFormat� 0 
localecode 
localeCode�  t ������� 0 	theformat 	theFormat� 0 
localecode 
localeCode� 0 theformatter theFormatter� 0 aref aRef� 0 isdate isDate� 0 
asocoption 
asocOptionu ���
�	��������� �������������
� misccura� "0 nsdateformatter NSDateFormatter�
 	0 alloc  �	 0 init  
� 
kocl
� 
ctxt
� .corecnte****       ****� 00 nsdateformatternostyle NSDateFormatterNoStyle� 0 setdatestyle_ setDateStyle_� 0 settimestyle_ setTimeStyle_� "0 aslistparameter asListParameter
� 
cobj
�  
pcnt�� 0 
_datestyle 
_dateStyle�� "0 astextparameter asTextParameter��  0 setdateformat_ setDateFormat_
�� 
msng��  0 _localeforcode _localeForCode�� 0 
setlocale_ 
setLocale_� ���,j+ j+ E�O�kv��l j  a���,k+ O���,k+ 	O Ib  �k+ 
[��l kh *��,�l+ E[�k/E�Z[�l/E�ZO� ��k+ Y ��k+ 	[OY��Y �b  ��l+ k+ O�a  �*b  �a l+ k+ k+ Y hO�J ��+����wx��
�� .Fmt:FDatnull���     ldt �� 0 thedate theDate�� ��yz
�� 
Usiny {����{�� 0 	theformat 	theFormat��  { ��|�� |  ��
�� FDStFDS1z ��}��
�� 
Loca} {�������� 0 
localecode 
localeCode��  
�� 
msng��  w ������������������ 0 thedate theDate�� 0 	theformat 	theFormat�� 0 
localecode 
localeCode�� 0 theformatter theFormatter�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTox 
G����������~d������ "0 asdateparameter asDateParameter�� (0 _makedateformatter _makeDateFormatter�� "0 stringfromdate_ stringFromDate_
�� 
ctxt�� 0 etext eText~ ����
�� 
errn�� 0 enumber eNumber �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 7 &b  ��l+ E�O*��l+ E�O��k+ �&W X  *礥���+ 	K ��t��������
�� .Fmt:PDatnull���     ctxt�� 0 thetext theText�� ����
�� 
Usin� {������� 0 	theformat 	theFormat��  � ����� �  ��
�� FDStFDS1� �����
�� 
Loca� {�������� 0 
localecode 
localeCode��  
�� 
msng��  � 	�������������������� 0 thetext theText�� 0 	theformat 	theFormat�� 0 
localecode 
localeCode�� 0 theformatter theFormatter�� 0 thedate theDate�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ������������������������������ "0 astextparameter asTextParameter�� (0 _makedateformatter _makeDateFormatter�� "0 datefromstring_ dateFromString_
�� 
ldt 
�� 
msng
�� 
errn���Y
�� 
erob�� �� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� K :b  ��l+ E�O*��l+ E�O��k+ �&E�O��  )�����Y hW X  *������+ L �����������
�� .Fmt:FJSNnull���     ****�� 0 
jsonobject 
jsonObject�� �����
�� 
PrPr� {�������� "0 isprettyprinted isPrettyPrinted��  
�� boovtrue��  � 	�������������������� 0 
jsonobject 
jsonObject�� "0 isprettyprinted isPrettyPrinted�� 0 writeoptions writeOptions�� 0 thedata theData�� 0 theerror theError�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ���������������������������+��/�������������P������ (0 asbooleanparameter asBooleanParameter
�� misccura�� 80 nsjsonwritingprettyprinted NSJSONWritingPrettyPrinted�� *0 nsjsonserialization NSJSONSerialization�� (0 isvalidjsonobject_ isValidJSONObject_
�� 
errn���Y
�� 
erob�� 
�� 
obj �� F0 !datawithjsonobject_options_error_ !dataWithJSONObject_options_error_
�� 
cobj
�� 
msng�� ,0 localizeddescription localizedDescription�� 0 nsstring NSString�� 	0 alloc  �� ,0 nsutf8stringencoding NSUTF8StringEncoding�� 00 initwithdata_encoding_ initWithData_encoding_
�� 
ctxt�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ��~�}
� 
errt�~ 
0 eto eTo�}  �� �� 
0 _error  �� � �b  ��l+  
��,E�Y jE�O��,�k+  )�����Y hO��,���m+ E[�k/E�Z[�l/E�ZO��  )�����j+ %a %Y hO�a ,j+ ��a ,l+ a &W X  *a ����a + M �|`�{�z���y
�| .Fmt:PJSNnull���     ctxt�{ 0 jsontext jsonText�z �x��w
�x 
Frag� {�v�u�t�v *0 arefragmentsallowed areFragmentsAllowed�u  
�t boovfals�w  � 
�s�r�q�p�o�n�m�l�k�j�s 0 jsontext jsonText�r *0 arefragmentsallowed areFragmentsAllowed�q 0 readoptions readOptions�p 0 thedata theData�o 0 
jsonobject 
jsonObject�n 0 theerror theError�m 0 etext eText�l 0 enumber eNumber�k 0 efrom eFrom�j 
0 eto eTo� u�i��h�g�f�e�d�c�b�a�`�_�^�]�\�[�Z�Y��X��W�V���U�T�i "0 astextparameter asTextParameter�h (0 asbooleanparameter asBooleanParameter
�g misccura�f :0 nsjsonreadingallowfragments NSJSONReadingAllowFragments�e 0 nsstring NSString�d &0 stringwithstring_ stringWithString_�c ,0 nsutf8stringencoding NSUTF8StringEncoding�b (0 datausingencoding_ dataUsingEncoding_�a *0 nsjsonserialization NSJSONSerialization
�` 
obj �_ F0 !jsonobjectwithdata_options_error_ !JSONObjectWithData_options_error_
�^ 
cobj
�] 
msng
�\ 
errn�[�Y
�Z 
erob�Y �X ,0 localizeddescription localizedDescription
�W 
****�V 0 etext eText� �S�R�
�S 
errn�R 0 enumber eNumber� �Q�P�
�Q 
erob�P 0 efrom eFrom� �O�N�M
�O 
errt�N 
0 eto eTo�M  �U �T 
0 _error  �y � �b  ��l+ E�Ob  ��l+  
��,E�Y jE�O��,�k+ ��,k+ 	E�O��,���m+ E[�k/E�Z[�l/E�ZO��  )�a a �a a �j+ %a %Y hO�a &W X  *a ����a + N �L��K�J���I
�L .Fmt:FLitnull��� ��� null�K  �J �H�G�F
�H 
For_�G 0 thevalue theValue�F  � �E�D�C�B�A�@�?�E 0 thevalue theValue�D 0 oldtids oldTIDs�C 0 	textitems 	textItems�B 0 etext eText�A 0 enumber eNumber�@ 0 efrom eFrom�? 
0 eto eTo� )�>�=�<�;�:�9�8�7P�6U�5�4X�3�2�1�0k�/y������.�-��,���+�*�)�(��'�&
�> 
kocl
�= 
obj 
�< .corecnte****       ****
�; 
capp
�: 
bool
�9 
reco
�8 
rdat
�7 
scpt
�6 
pnam�5  �4  
�3 
pcls
�2 
ctxt
�1 
ascr
�0 
txdl
�/ 
citm� �%�$�#
�% 
errn�$�\�#  
�. 
want
�- 
ocid�, 0 description  
�+ 
For_
�* 
seld
�) .Fmt:FLitnull��� ��� null�( 0 etext eText� �"�!�
�" 
errn�! 0 enumber eNumber� � ��
�  
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  �' �& 
0 _error  �I\G�kv��l j 	 �kv��l j �&	 �kv��l j �&	 �kv��l j �& ��kv��l j  ��,%�%W 	X  �Y ���  o_ a ,E�Oa _ a ,FO�a -E�Oa _ a ,FO��&E�Oa _ a ,FO�a -E�Oa _ a ,FO��&E�O�_ a ,FOa �%a %Y  	��&W X  hY hO�kv��l j	 ��&a ,a  �& 4 a �j+ �&%a %W X  a *a  ��&a !,l "%Y hOa #W X $ %*a &����a '+ (O �%�����
� .Fmt:FTxtnull���     ctxt� 0 templatetext templateText� ���
� 
Usin� 0 	thevalues 	theValues�  � �����������
�	������ 0 templatetext templateText� 0 	thevalues 	theValues� 
0 regexp  � 0 
asocstring 
asocString�  0 asocmatcharray asocMatchArray� 0 resulttexts resultTexts� 0 
startindex 
startIndex� 0 i  � 0 
matchrange 
matchRange� 0 thetoken theToken�
 0 theitem theItem�	 0 oldtids oldTIDs� 0 
resulttext 
resultText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� $���E� ����������tu�������������������������������������3����� "0 aslistparameter asListParameter
� misccura� *0 nsregularexpression NSRegularExpression
�  
msng�� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� 
0 length  �� @0 matchesinstring_options_range_ matchesInString_options_range_�� 	0 count  ��  0 objectatindex_ objectAtIndex_�� 0 rangeatindex_ rangeAtIndex_�� 0 location  �� �� *0 substringwithrange_ substringWithRange_
�� 
ctxt
�� 
cobj
�� 
cha 
�� 
long��  � ������
�� 
errn���\��  
�� 
For_
�� .Fmt:FLitnull��� ��� null�� *0 substringfromindex_ substringFromIndex_
�� 
ascr
�� 
txdl�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �4b  �k+  E�O��,�j�m+ E�O��,�k+ E�O��jj�j+ lvm+ 	E�OjvE�OjE�O�� � �j�j+ kkh ��k+ jk+ E�O���j+ �a k+ a &�6FO��k+ a &E�O�a   	��6FY 3�a �a i/a &/E�O �a &�6FW X  *a �l �6FO�j+ �j+ E�[OY�vO��k+ a &�6FO_ a ,E�Oa _ a ,FO�a &E�O�_ a ,FO�VW X   *a !���] a "+ #P �����������
�� .aevtoappnull  �   � ****� k     �� ����  ��  ��  �  � $������
�� 
Usin
�� FDStFDS8
�� .Fmt:FDatnull���     ldt �� ���l ascr  ��ޭ
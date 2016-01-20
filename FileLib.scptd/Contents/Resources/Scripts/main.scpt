FasdUAS 1.101.10   ��   ��    k             l      ��  ��   �� FileLib -- common file system and path string operations

Caution:

- Coercing file identifier objects to �class bmrk� currently causes AS to crash.

Notes:

- Path manipulation commands all operate on POSIX paths, as those are reliable whereas HFS paths (which are already deprecated everywhere else in OS X) are not. As POSIX paths are the default, handler names do not include the word 'POSIX' as standard; other formats (HFS/Windows/file URL) must be explicitly indicated.

- Library handlers should use LibrarySupportLib's asPOSIXPathParameter(...) to validate user-supplied alias/furl/path parameters and normalize them as POSIX path strings (if a file object is specifically required, just coerce the path string to `POSIX file`). This should insulate library handlers from the worst of the mess that is AS's file identifier types.


TO DO:

- is there a Cocoa API to fuzzily convert IANA charset names to NSString encodings? if so, would be better than hardcoded list of encoding constants

- add `alias object` (`new alias`, `file alias`, etc?) convenience command for converting POSIX path to alias object? (analogous to `alias TEXT` specifier, except that it takes POSIX, not HFS, path); see also DateLib, which has similar debate over whether to provide `datetime` convenience command as concise version of `convert record to date` as a more robust alternative to `date TEXT` specifier 

- how does -[NSString stringWithContentsOfFile:encoding:error:] deal with BOM vs encoding param? If it always ignores BOM then, when user specifies any UTF* encoding, would it make sense to sniff file for BOM first and, if found, use that as encoding? (or add `any Unicode encoding` enum which explicitly requires BOM?)

- add `with/without byte order mark` option to `write file`? (Q. what does NSString's writeToFile... method normally do?) if NSString never includes BOM itself, BOM sequence will presumably have to be prefixed to text before converting it to NSString

- add `check path` command that can check if a path (or file identifier object) is an absolute path, `found on disk`, identifies a file/folder/disk/symlink/etc.

- support Windows path format in `convert path` (suspect this requires CoreFoundation calls, which is a pain)

- what is status of alias and bookmark objects in AS? (the former is deprecated everywhere else in OS X; the latter is poorly supported and rarely appears)

- what about including FileManager commands? (`move disk item`, `duplicate disk item`, `delete disk item` (move to trash/delete file only/recursively delete folders), `get disk item info`, `list disk item contents [with/without invisible items]`, etc) (this would overlap existing functionality in System Events, but TBH System Events' File Suite is glitchy and crap, and itself just duplicates functionality that is (or should be) already in Finder, so there's a good argument for deprecating System Events' File Suite in favor of library-based alternative; OTOH, am reluctant to implement full suite of file management handlers here unless that's likely to happen, otherwise that's just even more complexity for users to wade through; also, to be fair, SE's File Suite has advantage of AEOM support, allowing more sophisticated queries to be performed compared to library handlers

     � 	 	�   F i l e L i b   - -   c o m m o n   f i l e   s y s t e m   a n d   p a t h   s t r i n g   o p e r a t i o n s 
 
 C a u t i o n : 
 
 -   C o e r c i n g   f i l e   i d e n t i f i e r   o b j e c t s   t o   � c l a s s   b m r k �   c u r r e n t l y   c a u s e s   A S   t o   c r a s h . 
 
 N o t e s : 
 
 -   P a t h   m a n i p u l a t i o n   c o m m a n d s   a l l   o p e r a t e   o n   P O S I X   p a t h s ,   a s   t h o s e   a r e   r e l i a b l e   w h e r e a s   H F S   p a t h s   ( w h i c h   a r e   a l r e a d y   d e p r e c a t e d   e v e r y w h e r e   e l s e   i n   O S   X )   a r e   n o t .   A s   P O S I X   p a t h s   a r e   t h e   d e f a u l t ,   h a n d l e r   n a m e s   d o   n o t   i n c l u d e   t h e   w o r d   ' P O S I X '   a s   s t a n d a r d ;   o t h e r   f o r m a t s   ( H F S / W i n d o w s / f i l e   U R L )   m u s t   b e   e x p l i c i t l y   i n d i c a t e d . 
 
 -   L i b r a r y   h a n d l e r s   s h o u l d   u s e   L i b r a r y S u p p o r t L i b ' s   a s P O S I X P a t h P a r a m e t e r ( . . . )   t o   v a l i d a t e   u s e r - s u p p l i e d   a l i a s / f u r l / p a t h   p a r a m e t e r s   a n d   n o r m a l i z e   t h e m   a s   P O S I X   p a t h   s t r i n g s   ( i f   a   f i l e   o b j e c t   i s   s p e c i f i c a l l y   r e q u i r e d ,   j u s t   c o e r c e   t h e   p a t h   s t r i n g   t o   ` P O S I X   f i l e ` ) .   T h i s   s h o u l d   i n s u l a t e   l i b r a r y   h a n d l e r s   f r o m   t h e   w o r s t   o f   t h e   m e s s   t h a t   i s   A S ' s   f i l e   i d e n t i f i e r   t y p e s . 
 
 
 T O   D O : 
 
 -   i s   t h e r e   a   C o c o a   A P I   t o   f u z z i l y   c o n v e r t   I A N A   c h a r s e t   n a m e s   t o   N S S t r i n g   e n c o d i n g s ?   i f   s o ,   w o u l d   b e   b e t t e r   t h a n   h a r d c o d e d   l i s t   o f   e n c o d i n g   c o n s t a n t s 
 
 -   a d d   ` a l i a s   o b j e c t `   ( ` n e w   a l i a s ` ,   ` f i l e   a l i a s ` ,   e t c ? )   c o n v e n i e n c e   c o m m a n d   f o r   c o n v e r t i n g   P O S I X   p a t h   t o   a l i a s   o b j e c t ?   ( a n a l o g o u s   t o   ` a l i a s   T E X T `   s p e c i f i e r ,   e x c e p t   t h a t   i t   t a k e s   P O S I X ,   n o t   H F S ,   p a t h ) ;   s e e   a l s o   D a t e L i b ,   w h i c h   h a s   s i m i l a r   d e b a t e   o v e r   w h e t h e r   t o   p r o v i d e   ` d a t e t i m e `   c o n v e n i e n c e   c o m m a n d   a s   c o n c i s e   v e r s i o n   o f   ` c o n v e r t   r e c o r d   t o   d a t e `   a s   a   m o r e   r o b u s t   a l t e r n a t i v e   t o   ` d a t e   T E X T `   s p e c i f i e r   
 
 -   h o w   d o e s   - [ N S S t r i n g   s t r i n g W i t h C o n t e n t s O f F i l e : e n c o d i n g : e r r o r : ]   d e a l   w i t h   B O M   v s   e n c o d i n g   p a r a m ?   I f   i t   a l w a y s   i g n o r e s   B O M   t h e n ,   w h e n   u s e r   s p e c i f i e s   a n y   U T F *   e n c o d i n g ,   w o u l d   i t   m a k e   s e n s e   t o   s n i f f   f i l e   f o r   B O M   f i r s t   a n d ,   i f   f o u n d ,   u s e   t h a t   a s   e n c o d i n g ?   ( o r   a d d   ` a n y   U n i c o d e   e n c o d i n g `   e n u m   w h i c h   e x p l i c i t l y   r e q u i r e s   B O M ? ) 
 
 -   a d d   ` w i t h / w i t h o u t   b y t e   o r d e r   m a r k `   o p t i o n   t o   ` w r i t e   f i l e ` ?   ( Q .   w h a t   d o e s   N S S t r i n g ' s   w r i t e T o F i l e . . .   m e t h o d   n o r m a l l y   d o ? )   i f   N S S t r i n g   n e v e r   i n c l u d e s   B O M   i t s e l f ,   B O M   s e q u e n c e   w i l l   p r e s u m a b l y   h a v e   t o   b e   p r e f i x e d   t o   t e x t   b e f o r e   c o n v e r t i n g   i t   t o   N S S t r i n g 
 
 -   a d d   ` c h e c k   p a t h `   c o m m a n d   t h a t   c a n   c h e c k   i f   a   p a t h   ( o r   f i l e   i d e n t i f i e r   o b j e c t )   i s   a n   a b s o l u t e   p a t h ,   ` f o u n d   o n   d i s k ` ,   i d e n t i f i e s   a   f i l e / f o l d e r / d i s k / s y m l i n k / e t c . 
 
 -   s u p p o r t   W i n d o w s   p a t h   f o r m a t   i n   ` c o n v e r t   p a t h `   ( s u s p e c t   t h i s   r e q u i r e s   C o r e F o u n d a t i o n   c a l l s ,   w h i c h   i s   a   p a i n ) 
 
 -   w h a t   i s   s t a t u s   o f   a l i a s   a n d   b o o k m a r k   o b j e c t s   i n   A S ?   ( t h e   f o r m e r   i s   d e p r e c a t e d   e v e r y w h e r e   e l s e   i n   O S   X ;   t h e   l a t t e r   i s   p o o r l y   s u p p o r t e d   a n d   r a r e l y   a p p e a r s ) 
 
 -   w h a t   a b o u t   i n c l u d i n g   F i l e M a n a g e r   c o m m a n d s ?   ( ` m o v e   d i s k   i t e m ` ,   ` d u p l i c a t e   d i s k   i t e m ` ,   ` d e l e t e   d i s k   i t e m `   ( m o v e   t o   t r a s h / d e l e t e   f i l e   o n l y / r e c u r s i v e l y   d e l e t e   f o l d e r s ) ,   ` g e t   d i s k   i t e m   i n f o ` ,   ` l i s t   d i s k   i t e m   c o n t e n t s   [ w i t h / w i t h o u t   i n v i s i b l e   i t e m s ] ` ,   e t c )   ( t h i s   w o u l d   o v e r l a p   e x i s t i n g   f u n c t i o n a l i t y   i n   S y s t e m   E v e n t s ,   b u t   T B H   S y s t e m   E v e n t s '   F i l e   S u i t e   i s   g l i t c h y   a n d   c r a p ,   a n d   i t s e l f   j u s t   d u p l i c a t e s   f u n c t i o n a l i t y   t h a t   i s   ( o r   s h o u l d   b e )   a l r e a d y   i n   F i n d e r ,   s o   t h e r e ' s   a   g o o d   a r g u m e n t   f o r   d e p r e c a t i n g   S y s t e m   E v e n t s '   F i l e   S u i t e   i n   f a v o r   o f   l i b r a r y - b a s e d   a l t e r n a t i v e ;   O T O H ,   a m   r e l u c t a n t   t o   i m p l e m e n t   f u l l   s u i t e   o f   f i l e   m a n a g e m e n t   h a n d l e r s   h e r e   u n l e s s   t h a t ' s   l i k e l y   t o   h a p p e n ,   o t h e r w i s e   t h a t ' s   j u s t   e v e n   m o r e   c o m p l e x i t y   f o r   u s e r s   t o   w a d e   t h r o u g h ;   a l s o ,   t o   b e   f a i r ,   S E ' s   F i l e   S u i t e   h a s   a d v a n t a g e   o f   A E O M   s u p p o r t ,   a l l o w i n g   m o r e   s o p h i s t i c a t e d   q u e r i e s   t o   b e   p e r f o r m e d   c o m p a r e d   t o   l i b r a r y   h a n d l e r s 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l     ��  ��    J D--------------------------------------------------------------------     �   � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -      l     ��  ��      support     �        s u p p o r t   ! " ! l     ��������  ��  ��   "  # $ # l      % & ' % j    �� (�� 0 _supportlib _supportLib ( N     ) ) 4    �� *
�� 
scpt * m     + + � , , " L i b r a r y S u p p o r t L i b & "  used for parameter checking    ' � - - 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g $  . / . l     ��������  ��  ��   /  0 1 0 l     ��������  ��  ��   1  2 3 2 i   ! 4 5 4 I      �� 6���� 
0 _error   6  7 8 7 o      ���� 0 handlername handlerName 8  9 : 9 o      ���� 0 etext eText :  ; < ; o      ���� 0 enumber eNumber <  = > = o      ���� 0 efrom eFrom >  ?�� ? o      ���� 
0 eto eTo��  ��   5 n     @ A @ I    �� B���� &0 throwcommanderror throwCommandError B  C D C m     E E � F F  F i l e L i b D  G H G o    ���� 0 handlername handlerName H  I J I o    ���� 0 etext eText J  K L K o    	���� 0 enumber eNumber L  M N M o   	 
���� 0 efrom eFrom N  O�� O o   
 ���� 
0 eto eTo��  ��   A o     ���� 0 _supportlib _supportLib 3  P Q P l     ��������  ��  ��   Q  R S R l     ��������  ��  ��   S  T U T l     �� V W��   V J D--------------------------------------------------------------------    W � X X � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - U  Y Z Y l     �� [ \��   [  File Read/Write; these are atomic alternatives to StandardAdditions' File Read/Write suite, with better support for text encodings (incremental read/write is almost entirely useless in practice as AS doesn't have the capabilities or smarts to do it right)    \ � ] ]    F i l e   R e a d / W r i t e ;   t h e s e   a r e   a t o m i c   a l t e r n a t i v e s   t o   S t a n d a r d A d d i t i o n s '   F i l e   R e a d / W r i t e   s u i t e ,   w i t h   b e t t e r   s u p p o r t   f o r   t e x t   e n c o d i n g s   ( i n c r e m e n t a l   r e a d / w r i t e   i s   a l m o s t   e n t i r e l y   u s e l e s s   i n   p r a c t i c e   a s   A S   d o e s n ' t   h a v e   t h e   c a p a b i l i t i e s   o r   s m a r t s   t o   d o   i t   r i g h t ) Z  ^ _ ^ l     ��������  ��  ��   _  ` a ` h   " )�� b�� (0 _nsstringencodings _NSStringEncodings b k       c c  d e d l     �� f g��   f � � note: AS can't natively represent integers larger than 2^30, but as long as they're not larger than 2^50 (1e15) then AS's real (Double) representation will reliably coerce back to integer when passed to ASOC    g � h h�   n o t e :   A S   c a n ' t   n a t i v e l y   r e p r e s e n t   i n t e g e r s   l a r g e r   t h a n   2 ^ 3 0 ,   b u t   a s   l o n g   a s   t h e y ' r e   n o t   l a r g e r   t h a n   2 ^ 5 0   ( 1 e 1 5 )   t h e n   A S ' s   r e a l   ( D o u b l e )   r e p r e s e n t a t i o n   w i l l   r e l i a b l y   c o e r c e   b a c k   t o   i n t e g e r   w h e n   p a s s e d   t o   A S O C e  i j i j     ��� k�� 
0 _list_   k J     � l l  m n m l 	    o���� o J      p p  q r q m     ��
�� FEncFE01 r  s�� s m    ���� ��  ��  ��   n  t u t l 	   v���� v J     w w  x y x m    ��
�� FEncFE02 y  z�� z m    ���� 
��  ��  ��   u  { | { l 	   }���� } J     ~ ~   �  m    	��
�� FEncFE03 �  ��� � m   	 
 � � A�      ��  ��  ��   |  � � � l 	   ����� � J     � �  � � � m    ��
�� FEncFE04 �  ��� � m     � � A�     ��  ��  ��   �  � � � l 	   ����� � J     � �  � � � m    ��
�� FEncFE05 �  ��� � m     � � A�     ��  ��  ��   �  � � � l 	   ����� � J     � �  � � � m    ��
�� FEncFE06 �  ��� � m     � � A�      ��  ��  ��   �  � � � l 	   ����� � J     � �  � � � m    ��
�� FEncFE07 �  ��� � m     � � A�     ��  ��  ��   �  � � � l 	    ����� � J      � �  � � � m    ��
�� FEncFE11 �  ��� � m    ���� ��  ��  ��   �  � � � l 	   & ����� � J     & � �  � � � m     !��
�� FEncFE12 �  ��� � m   ! $���� ��  ��  ��   �  � � � l 	 & . ����� � J   & . � �  � � � m   & )��
�� FEncFE13 �  ��� � m   ) ,���� ��  ��  ��   �  � � � l 	 . 6 ����� � J   . 6 � �  � � � m   . 1��
�� FEncFE14 �  ��� � m   1 4���� 	��  ��  ��   �  � � � l 	 6 < ����� � J   6 < � �  � � � m   6 9��
�� FEncFE15 �  ��� � m   9 :���� ��  ��  ��   �  � � � l 	 < D ����� � J   < D � �  � � � m   < ?��
�� FEncFE16 �  ��� � m   ? B���� ��  ��  ��   �  � � � l 	 D L ����� � J   D L � �  � � � m   D G��
�� FEncFE17 �  ��� � m   G J���� ��  ��  ��   �  � � � l 	 L T ����� � J   L T � �  � � � m   L O��
�� FEncFE18 �  ��� � m   O R���� ��  ��  ��   �  � � � l 	 T \ ���~ � J   T \ � �  � � � m   T W�}
�} FEncFE19 �  ��| � m   W Z�{�{ �|  �  �~   �  � � � l 	 \ d ��z�y � J   \ d � �  � � � m   \ _�x
�x FEncFE50 �  ��w � m   _ b�v�v �w  �z  �y   �  � � � l 	 d l ��u�t � J   d l � �  � � � m   d g�s
�s FEncFE51 �  ��r � m   g j�q�q �r  �u  �t   �  � � � l 	 l t ��p�o � J   l t � �  � � � m   l o�n
�n FEncFE52 �  ��m � m   o r�l�l �m  �p  �o   �  � � � l 	 t | ��k�j � J   t | � �  � � � m   t w�i
�i FEncFE53 �  ��h � m   w z�g�g �h  �k  �j   �  ��f � l 	 | � ��e�d � J   | �    m   | �c
�c FEncFE54 �b m    ��a�a �b  �e  �d  �f   j  l     �`�_�^�`  �_  �^   �] i  � � I      �\	�[�\ 0 getencoding getEncoding	 
�Z
 o      �Y�Y 0 textencoding textEncoding�Z  �[   k     V  Q     K k    3  r     c     o    �X�X 0 textencoding textEncoding m    �W
�W 
enum o      �V�V 0 textencoding textEncoding �U X   	 3�T Z   .�S�R =   ! n     4    �Q!
�Q 
cobj! m    �P�P   o    �O�O 0 aref aRef o     �N�N 0 textencoding textEncoding L   $ *"" n  $ )#$# 4   % (�M%
�M 
cobj% m   & '�L�L $ o   $ %�K�K 0 aref aRef�S  �R  �T 0 aref aRef n   &'& o    �J�J 
0 _list_  '  f    �U   R      �I�H(
�I .ascrerr ****      � ****�H  ( �G)�F
�G 
errn) d      ** m      �E�E��F   l  ; K+,-+ Q   ; K./0. L   > B11 c   > A232 o   > ?�D�D 0 textencoding textEncoding3 m   ? @�C
�C 
long/ R      �B�A4
�B .ascrerr ****      � ****�A  4 �@5�?
�@ 
errn5 d      66 m      �>�>��?  0 l  J J�=78�=  7   fall through   8 �99    f a l l   t h r o u g h, ] W not a predefined constant, but hedge bets as it might be a raw NSStringEncoding number   - �:: �   n o t   a   p r e d e f i n e d   c o n s t a n t ,   b u t   h e d g e   b e t s   a s   i t   m i g h t   b e   a   r a w   N S S t r i n g E n c o d i n g   n u m b e r ;�<; R   L V�;<=
�; .ascrerr ****      � ****< m   T U>> �?? h I n v a l i d    u s i n g    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .= �:@A
�: 
errn@ m   N O�9�9�YA �8BC
�8 
erobB o   P Q�7�7 0 textencoding textEncodingC �6D�5
�6 
errtD m   R S�4
�4 
enum�5  �<  �]   a EFE l     �3�2�1�3  �2  �1  F GHG l     �0�/�.�0  �/  �.  H IJI l     �-KL�-  K  -----   L �MM 
 - - - - -J NON l     �,�+�*�,  �+  �*  O PQP l     �)RS�)  R C = TO DO: option to determine UTF8 encoding from BOM, if found?   S �TT z   T O   D O :   o p t i o n   t o   d e t e r m i n e   U T F 8   e n c o d i n g   f r o m   B O M ,   i f   f o u n d ?Q UVU l     �(�'�&�(  �'  �&  V WXW i  * -YZY I     �%[\
�% .Fil:Readnull���     file[ o      �$�$ 0 thefile theFile\ �#]^
�# 
Type] |�"�!_� `�"  �!  _ o      �� 0 datatype dataType�   ` l     a��a m      �
� 
ctxt�  �  ^ �b�
� 
Encob |��c�d�  �  c o      �� 0 textencoding textEncoding�  d l     e��e m      �
� FEncFE01�  �  �  Z Q     �fghf k    �ii jkj r    lml n   non I    �p�� ,0 asposixpathparameter asPOSIXPathParameterp qrq o    	�� 0 thefile theFiler s�s m   	 
tt �uu  �  �  o o    �� 0 _supportlib _supportLibm o      �� 0 	posixpath 	posixPathk vwv r    xyx n   z{z I    �|�� "0 astypeparameter asTypeParameter| }~} o    �
�
 0 datatype dataType~ �	 m    �� ���  a s�	  �  { o    �� 0 _supportlib _supportLiby o      �� 0 datatype dataTypew ��� Z    ������ F    *��� =   "��� o     �� 0 datatype dataType� m     !�
� 
ctxt� >  % (��� o   % &�� 0 textencoding textEncoding� m   & '�
� FEncFEPE� l  - ����� k   - ��� ��� r   - 9��� n  - 7��� I   2 7� ����  0 getencoding getEncoding� ���� o   2 3���� 0 textencoding textEncoding��  ��  � o   - 2���� (0 _nsstringencodings _NSStringEncodings� o      ���� 0 textencoding textEncoding� ��� r   : S��� n  : D��� I   = D������� T0 (stringwithcontentsoffile_encoding_error_ (stringWithContentsOfFile_encoding_error_� ��� o   = >���� 0 	posixpath 	posixPath� ��� o   > ?���� 0 textencoding textEncoding� ���� l  ? @������ m   ? @��
�� 
obj ��  ��  ��  ��  � n  : =��� o   ; =���� 0 nsstring NSString� m   : ;��
�� misccura� J      �� ��� o      ���� 0 	theresult 	theResult� ���� o      ���� 0 theerror theError��  � ��� Z  T x������� =  T W��� o   T U���� 0 	theresult 	theResult� m   U V��
�� 
msng� R   Z t����
�� .ascrerr ****      � ****� l  l s������ c   l s��� n  l q��� I   m q�������� ,0 localizeddescription localizedDescription��  ��  � o   l m���� 0 theerror theError� m   q r��
�� 
ctxt��  ��  � ����
�� 
errn� n  \ a��� I   ] a�������� 0 code  ��  ��  � o   \ ]���� 0 theerror theError� ����
�� 
erob� o   d e���� 0 thefile theFile� �����
�� 
errt� o   h i���� 0 datatype dataType��  ��  ��  � ��� l  y y��������  ��  ��  � ��� I  y ������
�� .ascrcmnt****      � ****� l  y ~������ n  y ~��� I   z ~�������� 0 description  ��  ��  � o   y z���� 0 	theresult 	theResult��  ��  ��  � ��� l  � ���������  ��  ��  � ���� L   � ��� c   � ���� o   � ����� 0 	theresult 	theResult� m   � ���
�� 
ctxt��  �'! note: AS treats `text`, `string`, and `Unicode text` as synonyms when comparing for equality, which is a little bit problematic as StdAdds' `read` command treats `string` as 'primary encoding' and `Unicode text` as UTF16; passing `primary encoding` for `using` parameter provides an 'out'   � ���B   n o t e :   A S   t r e a t s   ` t e x t ` ,   ` s t r i n g ` ,   a n d   ` U n i c o d e   t e x t `   a s   s y n o n y m s   w h e n   c o m p a r i n g   f o r   e q u a l i t y ,   w h i c h   i s   a   l i t t l e   b i t   p r o b l e m a t i c   a s   S t d A d d s '   ` r e a d `   c o m m a n d   t r e a t s   ` s t r i n g `   a s   ' p r i m a r y   e n c o d i n g '   a n d   ` U n i c o d e   t e x t `   a s   U T F 1 6 ;   p a s s i n g   ` p r i m a r y   e n c o d i n g `   f o r   ` u s i n g `   p a r a m e t e r   p r o v i d e s   a n   ' o u t '�  � k   � ��� ��� r   � ���� I  � ������
�� .rdwropenshor       file� l  � ������� c   � ���� o   � ����� 0 	posixpath 	posixPath� m   � ���
�� 
psxf��  ��  ��  � o      ���� 0 fh  � ���� Q   � ����� k   � ��� ��� l  � ����� r   � ���� I  � �����
�� .rdwrread****        ****� o   � ����� 0 fh  � �����
�� 
as  � o   � ����� 0 datatype dataType��  � o      ���� 0 	theresult 	theResult� r l TO DO: how to produce better error messages (e.g. passing wrong dataType just gives 'Parameter error.' -50)   � ��� �   T O   D O :   h o w   t o   p r o d u c e   b e t t e r   e r r o r   m e s s a g e s   ( e . g .   p a s s i n g   w r o n g   d a t a T y p e   j u s t   g i v e s   ' P a r a m e t e r   e r r o r . '   - 5 0 )� ��� I  � ������
�� .rdwrclosnull���     ****� o   � ����� 0 fh  ��  � ���� L   � ��� o   � ����� 0 	theresult 	theResult��  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � k   � ��� ��� Q   � ������ I  � ������
�� .rdwrclosnull���     ****� o   � ����� 0 fh  ��  � R      ������
�� .ascrerr ****      � ****��  ��  ��  � ���� R   � �����
�� .ascrerr ****      � ****� o   � ����� 0 etext eText� ����
�� 
errn� o   � ����� 0 enumber eNumber� ����
�� 
erob� o   � ����� 0 efrom eFrom� �� ��
�� 
errt  o   � ����� 
0 eto eTo��  ��  ��  �  g R      ��
�� .ascrerr ****      � **** o      ���� 0 etext eText ��
�� 
errn o      ���� 0 enumber eNumber ��
�� 
erob o      ���� 0 efrom eFrom ����
�� 
errt o      ���� 
0 eto eTo��  h I   � ������� 
0 _error   	
	 m   � � �  r e a d   f i l e
  o   � ����� 0 etext eText  o   � ����� 0 enumber eNumber  o   � ����� 0 efrom eFrom �� o   � ����� 
0 eto eTo��  ��  X  l     ��������  ��  ��    l     ��������  ��  ��    i  . 1 I     ��
�� .Fil:Writnull���     file o      ���� 0 thefile theFile ��
�� 
Data o      ���� 0 thedata theData � !
� 
Type  |�~�}"�|#�~  �}  " o      �{�{ 0 datatype dataType�|  # l     $�z�y$ m      �x
�x 
ctxt�z  �y  ! �w%�v
�w 
Enco% |�u�t&�s'�u  �t  & o      �r�r 0 textencoding textEncoding�s  ' l     (�q�p( m      �o
�o FEncFE01�q  �p  �v   Q    	)*+) k    �,, -.- r    /0/ n   121 I    �n3�m�n ,0 asposixpathparameter asPOSIXPathParameter3 454 o    	�l�l 0 thefile theFile5 6�k6 m   	 
77 �88  �k  �m  2 o    �j�j 0 _supportlib _supportLib0 o      �i�i 0 	posixpath 	posixPath. 9:9 r    ;<; n   =>= I    �h?�g�h "0 astypeparameter asTypeParameter? @A@ o    �f�f 0 datatype dataTypeA B�eB m    CC �DD  a s�e  �g  > o    �d�d 0 _supportlib _supportLib< o      �c�c 0 datatype dataType: E�bE Z    �FG�aHF F    *IJI =   "KLK o     �`�` 0 datatype dataTypeL m     !�_
�_ 
ctxtJ >  % (MNM o   % &�^�^ 0 textencoding textEncodingN m   & '�]
�] FEncFEPEG k   - �OO PQP r   - ARSR n  - ?TUT I   0 ?�\V�[�\ &0 stringwithstring_ stringWithString_V W�ZW l  0 ;X�Y�XX n  0 ;YZY I   5 ;�W[�V�W "0 astextparameter asTextParameter[ \]\ o   5 6�U�U 0 thedata theData] ^�T^ m   6 7__ �``  d a t a�T  �V  Z o   0 5�S�S 0 _supportlib _supportLib�Y  �X  �Z  �[  U n  - 0aba o   . 0�R�R 0 nsstring NSStringb m   - .�Q
�Q misccuraS o      �P�P 0 
asocstring 
asocStringQ cdc r   B Nefe n  B Lghg I   G L�Oi�N�O 0 getencoding getEncodingi j�Mj o   G H�L�L 0 textencoding textEncoding�M  �N  h o   B G�K�K (0 _nsstringencodings _NSStringEncodingsf o      �J�J 0 textencoding textEncodingd klk r   O kmnm n  O Xopo I   P X�Iq�H�I P0 &writetofile_atomically_encoding_error_ &writeToFile_atomically_encoding_error_q rsr o   P Q�G�G 0 	posixpath 	posixPaths tut m   Q R�F
�F boovtrueu vwv o   R S�E�E 0 textencoding textEncodingw x�Dx l  S Ty�C�By m   S T�A
�A 
obj �C  �B  �D  �H  p o   O P�@�@ 0 
asocstring 
asocStringn J      zz {|{ o      �?�? 0 
didsucceed 
didSucceed| }�>} o      �=�= 0 theerror theError�>  l ~�<~ Z   l ���;�: H   l n�� o   l m�9�9 0 
didsucceed 
didSucceed� R   q ��8��
�8 .ascrerr ****      � ****� l  � ���7�6� c   � ���� n  � ���� I   � ��5�4�3�5 ,0 localizeddescription localizedDescription�4  �3  � o   � ��2�2 0 theerror theError� m   � ��1
�1 
ctxt�7  �6  � �0��
�0 
errn� n  u z��� I   v z�/�.�-�/ 0 code  �.  �-  � o   u v�,�, 0 theerror theError� �+��
�+ 
erob� o   } ~�*�* 0 thefile theFile� �)��(
�) 
errt� o   � ��'�' 0 datatype dataType�(  �;  �:  �<  �a  H k   � ��� ��� r   � ���� I  � ��&��
�& .rdwropenshor       file� l  � ���%�$� c   � ���� o   � ��#�# 0 	posixpath 	posixPath� m   � ��"
�" 
psxf�%  �$  � �!�� 
�! 
perm� m   � ��
� boovtrue�   � o      �� 0 fh  � ��� Q   � ����� k   � ��� ��� l  � ����� I  � ����
� .rdwrseofnull���     ****� o   � ��� 0 fh  � ���
� 
set2� m   � ���  �  � e _ important: when overwriting an existing file, make sure its previous contents are erased first   � ��� �   i m p o r t a n t :   w h e n   o v e r w r i t i n g   a n   e x i s t i n g   f i l e ,   m a k e   s u r e   i t s   p r e v i o u s   c o n t e n t s   a r e   e r a s e d   f i r s t� ��� l  � ����� I  � ����
� .rdwrwritnull���     ****� o   � ��� 0 thedata theData� ���
� 
refn� o   � ��� 0 fh  � ���
� 
as  � o   � ��� 0 datatype dataType�  � 2 , TO DO: how to produce better error messages   � ��� X   T O   D O :   h o w   t o   p r o d u c e   b e t t e r   e r r o r   m e s s a g e s� ��� I  � ����
� .rdwrclosnull���     ****� o   � ��� 0 fh  �  � ��� L   � ��� o   � ��� 0 	theresult 	theResult�  � R      ���
� .ascrerr ****      � ****� o      �
�
 0 etext eText� �	��
�	 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � k   � ��� ��� Q   � ����� I  � ���� 
� .rdwrclosnull���     ****� o   � ����� 0 fh  �   � R      ������
�� .ascrerr ****      � ****��  ��  �  � ���� R   � �����
�� .ascrerr ****      � ****� o   � ����� 0 etext eText� ����
�� 
errn� o   � ����� 0 enumber eNumber� ����
�� 
erob� o   � ����� 0 efrom eFrom� �����
�� 
errt� o   � ����� 
0 eto eTo��  ��  �  �b  * R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  + I   �	������� 
0 _error  � ��� m   � ��� ���  w r i t e   f i l e� ��� o   � ���� 0 etext eText� ��� o   ���� 0 enumber eNumber� ��� o  ���� 0 efrom eFrom� ���� o  ���� 
0 eto eTo��  ��   ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ������  �   POSIX path manipulation   � ��� 0   P O S I X   p a t h   m a n i p u l a t i o n� ��� l     ��������  ��  ��  � ��� i  2 5��� I     ����
�� .Fil:ConPnull���     ****� o      ���� 0 filepath filePath� ����
�� 
From� |����������  ��  � o      ���� 0 
fromformat 
fromFormat��  � l     ������ m      ��
�� FLCTFLCP��  ��  � �����
�� 
To__� |����������  ��  � o      ���� 0 toformat toFormat��  � l     ������ m      ��
�� FLCTFLCP��  ��  ��  � l   �   Q    � k     Z    �	
��	 =     l   ���� I   ��
�� .corecnte****       **** J     �� o    ���� 0 filepath filePath��   ����
�� 
kocl m    ��
�� 
ctxt��  ��  ��   m    ����  
 l    r     n    I    ������ ,0 asposixpathparameter asPOSIXPathParameter  o    ���� 0 filepath filePath �� m     �    ��  ��   o    ���� 0 _supportlib _supportLib o      ���� 0 	posixpath 	posixPath F @ assume it's a file identifier object (alias, �class furl�, etc)    �!! �   a s s u m e   i t ' s   a   f i l e   i d e n t i f i e r   o b j e c t   ( a l i a s ,   � c l a s s   f u r l � ,   e t c )��   l  ! �"#$" Z   ! �%&'(% =  ! $)*) o   ! "���� 0 
fromformat 
fromFormat* m   " #��
�� FLCTFLCP& r   ' *+,+ o   ' (���� 0 filepath filePath, o      ���� 0 	posixpath 	posixPath' -.- =  - 0/0/ o   - .���� 0 
fromformat 
fromFormat0 m   . /��
�� FLCTFLCH. 121 l  3 ;3453 r   3 ;676 n   3 9898 1   7 9��
�� 
psxp9 l  3 7:����: 4   3 7��;
�� 
file; o   5 6���� 0 filepath filePath��  ��  7 o      ���� 0 	posixpath 	posixPath4 � � caution: HFS path format is flawed and deprecated everywhere else in OS X (unlike POSIX path format, it can't distinguish between two volumes with the same name), but is still used by AS and a few older scriptable apps so must be supported   5 �<<�   c a u t i o n :   H F S   p a t h   f o r m a t   i s   f l a w e d   a n d   d e p r e c a t e d   e v e r y w h e r e   e l s e   i n   O S   X   ( u n l i k e   P O S I X   p a t h   f o r m a t ,   i t   c a n ' t   d i s t i n g u i s h   b e t w e e n   t w o   v o l u m e s   w i t h   t h e   s a m e   n a m e ) ,   b u t   i s   s t i l l   u s e d   b y   A S   a n d   a   f e w   o l d e r   s c r i p t a b l e   a p p s   s o   m u s t   b e   s u p p o r t e d2 =>= =  > A?@? o   > ?���� 0 
fromformat 
fromFormat@ m   ? @��
�� FLCTFLCW> ABA l  D HCDEC R   D H��F��
�� .ascrerr ****      � ****F m   F GGG �HH ^ T O D O :   W i n d o w s   p a t h   c o n v e r s i o n   n o t   y e t   s u p p o r t e d��  D W Q CFURLCreateWithFileSystemPath(NULL,(CFStringRef)path,kCFURLWindowsPathStyle,0);    E �II �   C F U R L C r e a t e W i t h F i l e S y s t e m P a t h ( N U L L , ( C F S t r i n g R e f ) p a t h , k C F U R L W i n d o w s P a t h S t y l e , 0 ) ;  B JKJ =  K NLML o   K L���� 0 
fromformat 
fromFormatM m   L M��
�� FLCTFLCUK N��N k   Q �OO PQP r   Q [RSR n  Q YTUT I   T Y��V����  0 urlwithstring_ URLWithString_V W��W o   T U���� 0 filepath filePath��  ��  U n  Q TXYX o   R T���� 0 nsurl NSURLY m   Q R��
�� misccuraS o      ���� 0 asocurl asocURLQ Z��Z Z  \ �[\����[ G   \ l]^] =  \ __`_ o   \ ]���� 0 asocurl asocURL` m   ] ^��
�� 
msng^ H   b haa n  b gbcb I   c g�������� 0 fileurl fileURL��  ��  c o   b c���� 0 asocurl asocURL\ R   o ���de
�� .ascrerr ****      � ****d m   } �ff �gg T I n v a l i d   d i r e c t   p a r a m e t e r   ( n o t   a   f i l e   U R L ) .e ��hi
�� 
errnh m   s v�����Yi ��j��
�� 
erobj o   y z���� 0 filepath filePath��  ��  ��  ��  ��  ( R   � ���kl
�� .ascrerr ****      � ****k m   � �mm �nn f I n v a l i d    f r o m    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .l ��op
�� 
errno m   � ������Yp ��qr
�� 
erobq o   � ����� 0 
fromformat 
fromFormatr ��s��
�� 
errts m   � ���
�� 
enum��  # \ V it's a text path in the user-specified format, so convert it to a standard POSIX path   $ �tt �   i t ' s   a   t e x t   p a t h   i n   t h e   u s e r - s p e c i f i e d   f o r m a t ,   s o   c o n v e r t   i t   t o   a   s t a n d a r d   P O S I X   p a t h uvu l  � ���wx��  w   sanity check   x �yy    s a n i t y   c h e c kv z{z l  � �|}~| Z  � ������ =   � ���� n  � ���� 1   � ��
� 
leng� o   � ��~�~ 0 	posixpath 	posixPath� m   � ��}�}  � R   � ��|��
�| .ascrerr ****      � ****� m   � ��� ��� L I n v a l i d   d i r e c t   p a r a m e t e r   ( e m p t y   p a t h ) .� �{��
�{ 
errn� m   � ��z�z�Y� �y��x
�y 
erob� o   � ��w�w 0 filepath filePath�x  ��  ��  } B < TO DO: what, if any, additional validation to perform here?   ~ ��� x   T O   D O :   w h a t ,   i f   a n y ,   a d d i t i o n a l   v a l i d a t i o n   t o   p e r f o r m   h e r e ?{ ��� l  � ��v���v  � ; 5 convert POSIX path text to the requested format/type   � ��� j   c o n v e r t   P O S I X   p a t h   t e x t   t o   t h e   r e q u e s t e d   f o r m a t / t y p e� ��u� Z   ������ =  � ���� o   � ��t�t 0 toformat toFormat� m   � ��s
�s FLCTFLCP� L   � ��� o   � ��r�r 0 	posixpath 	posixPath� ��� =  � ���� o   � ��q�q 0 toformat toFormat� m   � ��p
�p FLCTFLCA� ��� l  � ����� L   � ��� c   � ���� c   � ���� o   � ��o�o 0 	posixpath 	posixPath� m   � ��n
�n 
psxf� m   � ��m
�m 
alis� %  returns object of type `alias`   � ��� >   r e t u r n s   o b j e c t   o f   t y p e   ` a l i a s `� ��� =  � ���� o   � ��l�l 0 toformat toFormat� m   � ��k
�k FLCTFLCX� ��� l  � ����� L   � ��� c   � ���� o   � ��j�j 0 	posixpath 	posixPath� m   � ��i
�i 
psxf� , & returns object of type `�class furl�`   � ��� L   r e t u r n s   o b j e c t   o f   t y p e   ` � c l a s s   f u r l � `� ��� =  � ���� o   � ��h�h 0 toformat toFormat� m   � ��g
�g FLCTFLCS� ��� l  �	���� L   �	�� N   ��� n   ���� 4   ��f�
�f 
file� l  ���e�d� c   ���� c   ���� o   � �c�c 0 	posixpath 	posixPath� m   �b
�b 
psxf� m  �a
�a 
ctxt�e  �d  � 1   � ��`
�` 
ascr�NH returns an _object specifier_ of type 'file'. Caution: unlike alias and �class furl� objects, this is not a true object but may be used by some applications; not to be confused with the deprecated `file specifier` type (�class fss�), although it uses the same `file TEXT` constructor. Furthermore, it uses an HFS path string so suffers the same problems as HFS paths. Also, being a specifier, requires disambiguation when used [e.g.] in an `open` command otherwise command will be dispatched to it instead of target app, e.g. `tell app "TextEdit" to open {fileSpecifierObject}`. Horribly nasty, brittle, and confusing mis-feature, in other words, but supported (though not encouraged) as an option here for sake of compatibility as there's usually some scriptable app or other API in AS that will absolutely refuse to accept anything else.   � ����   r e t u r n s   a n   _ o b j e c t   s p e c i f i e r _   o f   t y p e   ' f i l e ' .   C a u t i o n :   u n l i k e   a l i a s   a n d   � c l a s s   f u r l �   o b j e c t s ,   t h i s   i s   n o t   a   t r u e   o b j e c t   b u t   m a y   b e   u s e d   b y   s o m e   a p p l i c a t i o n s ;   n o t   t o   b e   c o n f u s e d   w i t h   t h e   d e p r e c a t e d   ` f i l e   s p e c i f i e r `   t y p e   ( � c l a s s   f s s � ) ,   a l t h o u g h   i t   u s e s   t h e   s a m e   ` f i l e   T E X T `   c o n s t r u c t o r .   F u r t h e r m o r e ,   i t   u s e s   a n   H F S   p a t h   s t r i n g   s o   s u f f e r s   t h e   s a m e   p r o b l e m s   a s   H F S   p a t h s .   A l s o ,   b e i n g   a   s p e c i f i e r ,   r e q u i r e s   d i s a m b i g u a t i o n   w h e n   u s e d   [ e . g . ]   i n   a n   ` o p e n `   c o m m a n d   o t h e r w i s e   c o m m a n d   w i l l   b e   d i s p a t c h e d   t o   i t   i n s t e a d   o f   t a r g e t   a p p ,   e . g .   ` t e l l   a p p   " T e x t E d i t "   t o   o p e n   { f i l e S p e c i f i e r O b j e c t } ` .   H o r r i b l y   n a s t y ,   b r i t t l e ,   a n d   c o n f u s i n g   m i s - f e a t u r e ,   i n   o t h e r   w o r d s ,   b u t   s u p p o r t e d   ( t h o u g h   n o t   e n c o u r a g e d )   a s   a n   o p t i o n   h e r e   f o r   s a k e   o f   c o m p a t i b i l i t y   a s   t h e r e ' s   u s u a l l y   s o m e   s c r i p t a b l e   a p p   o r   o t h e r   A P I   i n   A S   t h a t   w i l l   a b s o l u t e l y   r e f u s e   t o   a c c e p t   a n y t h i n g   e l s e .� ��� = ��� o  �_�_ 0 toformat toFormat� m  �^
�^ FLCTFLCH� ��� L  �� c  ��� c  ��� o  �]�] 0 	posixpath 	posixPath� m  �\
�\ 
psxf� m  �[
�[ 
ctxt� ��� =  ��� o  �Z�Z 0 toformat toFormat� m  �Y
�Y FLCTFLCW� ��� l #)���� R  #)�X��W
�X .ascrerr ****      � ****� m  %(�� ��� ^ T O D O :   W i n d o w s   p a t h   c o n v e r s i o n   n o t   y e t   s u p p o r t e d�W  � F @ CFURLCopyFileSystemPath((CFURLRef)url, kCFURLWindowsPathStyle);   � ��� �   C F U R L C o p y F i l e S y s t e m P a t h ( ( C F U R L R e f ) u r l ,   k C F U R L W i n d o w s P a t h S t y l e ) ;� ��� = ,/��� o  ,-�V�V 0 toformat toFormat� m  -.�U
�U FLCTFLCU� ��T� k  2d�� ��� r  2<��� n 2:��� I  5:�S��R�S $0 fileurlwithpath_ fileURLWithPath_� ��Q� o  56�P�P 0 	posixpath 	posixPath�Q  �R  � n 25��� o  35�O�O 0 nsurl NSURL� m  23�N
�N misccura� o      �M�M 0 asocurl asocURL� ��� Z  =[���L�K� = =@��� o  =>�J�J 0 asocurl asocURL� m  >?�I
�I 
msng� R  CW�H��
�H .ascrerr ****      � ****� b  QV��� m  QT�� ��� f C o u l d n ' t   c o n v e r t   t h e   f o l l o w i n g   p a t h   t o   a   f i l e   U R L :  � o  TU�G�G 0 	posixpath 	posixPath� �F��
�F 
errn� m  GJ�E�E�Y� �D �C
�D 
erob  o  MN�B�B 0 filepath filePath�C  �L  �K  � �A L  \d c  \c l \a�@�? n \a I  ]a�>�=�<�>  0 absolutestring absoluteString�=  �<   o  \]�;�; 0 asocurl asocURL�@  �?   m  ab�:
�: 
ctxt�A  �T  � R  g�9	
�9 .ascrerr ****      � **** m  {~

 � b I n v a l i d    t o    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .	 �8
�8 
errn m  kn�7�7�Y �6
�6 
erob o  qr�5�5 0 toformat toFormat �4�3
�4 
errt m  ux�2
�2 
enum�3  �u   R      �1
�1 .ascrerr ****      � **** o      �0�0 0 etext eText �/
�/ 
errn o      �.�. 0 enumber eNumber �-
�- 
erob o      �,�, 0 efrom eFrom �+�*
�+ 
errt o      �)�) 
0 eto eTo�*   I  ���(�'�( 
0 _error    m  �� �  c o n v e r t   p a t h  o  ���&�& 0 etext eText   o  ���%�% 0 enumber eNumber  !"! o  ���$�$ 0 efrom eFrom" #�## o  ���"�" 
0 eto eTo�#  �'   x r brings a modicum of sanity to the horrible mess that is AppleScript's file path formats and file identifier types    �$$ �   b r i n g s   a   m o d i c u m   o f   s a n i t y   t o   t h e   h o r r i b l e   m e s s   t h a t   i s   A p p l e S c r i p t ' s   f i l e   p a t h   f o r m a t s   a n d   f i l e   i d e n t i f i e r   t y p e s� %&% l     �!� ��!  �   �  & '(' l     ����  �  �  ( )*) i  6 9+,+ I     �-�
� .Fil:NorPnull���     ****- o      �� 0 filepath filePath�  , Q     2./0. k     11 232 r    454 n   676 I    �8�� ,0 asposixpathparameter asPOSIXPathParameter8 9:9 o    	�� 0 filepath filePath: ;�; m   	 
<< �==  �  �  7 o    �� 0 _supportlib _supportLib5 o      �� 0 filepath filePath3 >�> L     ?? c    @A@ l   B��B n   CDC I    ���� 60 stringbystandardizingpath stringByStandardizingPath�  �  D l   E��E n   FGF I    �
H�	�
 &0 stringwithstring_ stringWithString_H I�I o    �� 0 filepath filePath�  �	  G n   JKJ o    �� 0 nsstring NSStringK m    �
� misccura�  �  �  �  A m    �
� 
ctxt�  / R      �LM
� .ascrerr ****      � ****L o      �� 0 etext eTextM �NO
� 
errnN o      � �  0 enumber eNumberO ��PQ
�� 
erobP o      ���� 0 efrom eFromQ ��R��
�� 
errtR o      ���� 
0 eto eTo��  0 I   ( 2��S���� 
0 _error  S TUT m   ) *VV �WW  n o r m a l i z e   p a t hU XYX o   * +���� 0 etext eTextY Z[Z o   + ,���� 0 enumber eNumber[ \]\ o   , -���� 0 efrom eFrom] ^��^ o   - .���� 
0 eto eTo��  ��  * _`_ l     ��������  ��  ��  ` aba l     ��������  ��  ��  b cdc i  : =efe I     ��gh
�� .Fil:JoiPnull���     ****g o      ����  0 pathcomponents pathComponentsh ��i��
�� 
Extei |����j��k��  ��  j o      ���� 0 fileextension fileExtension��  k l     l����l m      ��
�� 
msng��  ��  ��  f Q     �mnom k    �pp qrq r    sts n    uvu 2   ��
�� 
cobjv n   wxw I    ��y���� "0 aslistparameter asListParametery z{z o    	����  0 pathcomponents pathComponents{ |��| m   	 
}} �~~  ��  ��  x o    ���� 0 _supportlib _supportLibt o      ���� 0 subpaths subPathsr � Q    \���� k    L�� ��� Z   %������� =   ��� o    ���� 0 subpaths subPaths� J    ����  � R    !������
�� .ascrerr ****      � ****��  ��  ��  ��  � ���� X   & L����� l  6 G���� r   6 G��� n  6 C��� I   ; C������� ,0 asposixpathparameter asPOSIXPathParameter� ��� n  ; >��� 1   < >��
�� 
pcnt� o   ; <���� 0 aref aRef� ���� m   > ?�� ���  ��  ��  � o   6 ;���� 0 _supportlib _supportLib� n     ��� 1   D F��
�� 
pcnt� o   C D���� 0 aref aRef� | v TO DO: how should absolute paths after first item get handled? (e.g. Python's os.path.join discards everything prior)   � ��� �   T O   D O :   h o w   s h o u l d   a b s o l u t e   p a t h s   a f t e r   f i r s t   i t e m   g e t   h a n d l e d ?   ( e . g .   P y t h o n ' s   o s . p a t h . j o i n   d i s c a r d s   e v e r y t h i n g   p r i o r )�� 0 aref aRef� o   ) *���� 0 subpaths subPaths��  � R      ������
�� .ascrerr ****      � ****��  ��  � R   T \����
�� .ascrerr ****      � ****� m   Z [�� ��� � I n v a l i d   p a t h   c o m p o n e n t s   l i s t   ( e x p e c t e d   o n e   o r   m o r e   t e x t   a n d / o r   f i l e   i t e m s ) .� ����
�� 
errn� m   V W�����Y� �����
�� 
erob� o   X Y����  0 pathcomponents pathComponents��  � ��� r   ] i��� l  ] g������ n  ] g��� I   b g������� *0 pathwithcomponents_ pathWithComponents_� ���� o   b c���� 0 subpaths subPaths��  ��  � n  ] b��� o   ^ b���� 0 nsstring NSString� m   ] ^��
�� misccura��  ��  � o      ���� 0 asocpath asocPath� ��� Z   j �������� >  j o��� o   j k���� 0 fileextension fileExtension� m   k n��
�� 
msng� k   r ��� ��� r   r ���� n  r ��� I   w ������� "0 astextparameter asTextParameter� ��� o   w x���� 0 fileextension fileExtension� ���� m   x {�� ��� ( u s i n g   f i l e   e x t e n s i o n��  ��  � o   r w���� 0 _supportlib _supportLib� o      ���� 0 fileextension fileExtension� ��� l  � �������  � _ Y TO DO: trim any leading periods from extension? (NSString doesn't do this automatically)   � ��� �   T O   D O :   t r i m   a n y   l e a d i n g   p e r i o d s   f r o m   e x t e n s i o n ?   ( N S S t r i n g   d o e s n ' t   d o   t h i s   a u t o m a t i c a l l y )� ��� r   � ���� n  � ���� I   � �������� B0 stringbyappendingpathextension_ stringByAppendingPathExtension_� ���� o   � ����� 0 fileextension fileExtension��  ��  � o   � ����� 0 asocpath asocPath� o      ���� 0 asocpath asocPath� ���� Z  � �������� =  � ���� o   � ����� 0 asocpath asocPath� m   � ���
�� 
msng� R   � �����
�� .ascrerr ****      � ****� m   � ��� ��� . I n v a l i d   f i l e   e x t e n s i o n .� ����
�� 
errn� m   � ������Y� �����
�� 
erob� o   � ����� 0 fileextension fileExtension��  ��  ��  ��  ��  ��  � ���� L   � ��� c   � ���� o   � ����� 0 asocpath asocPath� m   � ���
�� 
ctxt��  n R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  o I   � �������� 
0 _error  � ��� m   � ��� ���  j o i n   p a t h� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  d ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  > A��� I     ����
�� .Fil:SplPnull���     ctxt� o      ���� 0 filepath filePath� ����
�� 
Upon� |�~�} �|�~  �}    o      �{�{ 0 splitposition splitPosition�|   l     �z�y m      �x
�x FLSPFLSL�z  �y  �  � Q     � k    s  r    	
	 n    I    �w�v�w &0 stringwithstring_ stringWithString_ �u l   �t�s n    I    �r�q�r ,0 asposixpathparameter asPOSIXPathParameter  o    �p�p 0 filepath filePath �o m     �  �o  �q   o    �n�n 0 _supportlib _supportLib�t  �s  �u  �v   n    o    �m�m 0 nsstring NSString m    �l
�l misccura
 o      �k�k 0 asocpath asocPath �j Z    s =     o    �i�i 0 splitposition splitPosition  m    �h
�h FLSPFLSL L    /!! J    ."" #$# c    %%&% l   #'�g�f' n   #()( I    #�e�d�c�e F0 !stringbydeletinglastpathcomponent !stringByDeletingLastPathComponent�d  �c  ) o    �b�b 0 asocpath asocPath�g  �f  & m   # $�a
�a 
ctxt$ *�`* c   % ,+,+ l  % *-�_�^- n  % *./. I   & *�]�\�[�] &0 lastpathcomponent lastPathComponent�\  �[  / o   % &�Z�Z 0 asocpath asocPath�_  �^  , m   * +�Y
�Y 
ctxt�`   010 =  2 5232 o   2 3�X�X 0 splitposition splitPosition3 m   3 4�W
�W FLSPFLSE1 454 L   8 I66 J   8 H77 898 c   8 ?:;: l  8 =<�V�U< n  8 ==>= I   9 =�T�S�R�T >0 stringbydeletingpathextension stringByDeletingPathExtension�S  �R  > o   8 9�Q�Q 0 asocpath asocPath�V  �U  ; m   = >�P
�P 
ctxt9 ?�O? c   ? F@A@ l  ? DB�N�MB n  ? DCDC I   @ D�L�K�J�L 0 pathextension pathExtension�K  �J  D o   ? @�I�I 0 asocpath asocPath�N  �M  A m   D E�H
�H 
ctxt�O  5 EFE =  L OGHG o   L M�G�G 0 splitposition splitPositionH m   M N�F
�F FLSPFLSAF I�EI L   R ZJJ c   R YKLK l  R WM�D�CM n  R WNON I   S W�B�A�@�B  0 pathcomponents pathComponents�A  �@  O o   R S�?�? 0 asocpath asocPath�D  �C  L m   W X�>
�> 
list�E   R   ] s�=PQ
�= .ascrerr ****      � ****P m   o rRR �SS b I n v a l i d    a t    p a r a m e t e r   ( n o t   a n   a l l o w e d   c o n s t a n t ) .Q �<TU
�< 
errnT m   _ b�;�;�YU �:VW
�: 
erobV o   e f�9�9 0 matchformat matchFormatW �8X�7
�8 
errtX m   i l�6
�6 
enum�7  �j   R      �5YZ
�5 .ascrerr ****      � ****Y o      �4�4 0 etext eTextZ �3[\
�3 
errn[ o      �2�2 0 enumber eNumber\ �1]^
�1 
erob] o      �0�0 0 efrom eFrom^ �/_�.
�/ 
errt_ o      �-�- 
0 eto eTo�.   I   { ��,`�+�, 
0 _error  ` aba m   | cc �dd  s p l i t   p a t hb efe o    ��*�* 0 etext eTextf ghg o   � ��)�) 0 enumber eNumberh iji o   � ��(�( 0 efrom eFromj k�'k o   � ��&�& 
0 eto eTo�'  �+  � lml l     �%�$�#�%  �$  �#  m n�"n l     �!� ��!  �   �  �"       �opqrstuvwxy�  o 
����������
� 
pimr� 0 _supportlib _supportLib� 
0 _error  � (0 _nsstringencodings _NSStringEncodings
� .Fil:Readnull���     file
� .Fil:Writnull���     file
� .Fil:ConPnull���     ****
� .Fil:NorPnull���     ****
� .Fil:JoiPnull���     ****
� .Fil:SplPnull���     ctxtp �z� z  {|{ �}�
� 
cobj} ~~   � 
� 
frmk�  | ��
� 
cobj ��   �
� 
osax�  q ��   � +
� 
scptr � 5�
�	���� 
0 _error  �
 ��� �  ������ 0 handlername handlerName� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo�	  � �� ������� 0 handlername handlerName�  0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo�  E������ �� &0 throwcommanderror throwCommandError� b  ࠡ����+ s �� b  ��� (0 _nsstringencodings _NSStringEncodings�  ���� ������ 
0 _list_  �� 0 getencoding getEncoding� ����� �  ���������������������� ����� �  ����
�� FEncFE01�� � ����� �  ����
�� FEncFE02�� 
� ����� �  �� �
�� FEncFE03� ����� �  �� �
�� FEncFE04� ����� �  �� �
�� FEncFE05� ����� �  �� �
�� FEncFE06� ����� �  �� �
�� FEncFE07� ����� �  ����
�� FEncFE11�� � ����� �  ����
�� FEncFE12�� � ����� �  ����
�� FEncFE13�� � ����� �  ����
�� FEncFE14�� 	� ����� �  ����
�� FEncFE15�� � ����� �  ����
�� FEncFE16�� � ����� �  ����
�� FEncFE17�� � ����� �  ����
�� FEncFE18�� � ����� �  ����
�� FEncFE19�� � ����� �  ����
�� FEncFE50�� � ����� �  ����
�� FEncFE51�� � ����� �  ����
�� FEncFE52�� � ����� �  ����
�� FEncFE53�� � ����� �  ����
�� FEncFE54�� � ������������ 0 getencoding getEncoding�� ����� �  ���� 0 textencoding textEncoding��  � ������ 0 textencoding textEncoding�� 0 aref aRef� �������������������������>
�� 
enum�� 
0 _list_  
�� 
kocl
�� 
cobj
�� .corecnte****       ****��  � ������
�� 
errn���\��  
�� 
long
�� 
errn���Y
�� 
erob
�� 
errt�� �� W 5��&E�O ))�,[��l kh ��k/�  ��l/EY h[OY��W X   	��&W X  hO)�������t ��Z��������
�� .Fil:Readnull���     file�� 0 thefile theFile�� ����
�� 
Type� {�������� 0 datatype dataType��  
�� 
ctxt� �����
�� 
Enco� {�������� 0 textencoding textEncoding��  
�� FEncFE01��  � ������������������������ 0 thefile theFile�� 0 datatype dataType�� 0 textencoding textEncoding�� 0 	posixpath 	posixPath�� 0 	theresult 	theResult�� 0 theerror theError�� 0 fh  �� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� "t�������������������������������~�}�|�{�z�y�x�w�v�u�t��s�r�q�p�� ,0 asposixpathparameter asPOSIXPathParameter�� "0 astypeparameter asTypeParameter
�� 
ctxt
�� FEncFEPE
�� 
bool�� 0 getencoding getEncoding
�� misccura�� 0 nsstring NSString
�� 
obj �� T0 (stringwithcontentsoffile_encoding_error_ (stringWithContentsOfFile_encoding_error_
�� 
cobj
�� 
msng
�� 
errn�� 0 code  
� 
erob
�~ 
errt�} �| ,0 localizeddescription localizedDescription�{ 0 description  
�z .ascrcmnt****      � ****
�y 
psxf
�x .rdwropenshor       file
�w 
as  
�v .rdwrread****        ****
�u .rdwrclosnull���     ****�t 0 etext eText� �o�n�
�o 
errn�n 0 enumber eNumber� �m�l�
�m 
erob�l 0 efrom eFrom� �k�j�i
�k 
errt�j 
0 eto eTo�i  �s  �r  �q �p 
0 _error  �� � �b  ��l+ E�Ob  ��l+ E�O�� 	 ���& _b  �k+ E�O��,���m+ E[�k/E�Z[�l/E�ZO��  )�j+ a �a �a �j+ �&Y hO�j+ j O��&Y O�a &j E�O �a �l E�O�j O�W )X   
�j W X  hO)�a �a �a �W X  *a ����a  + !u �h�g�f���e
�h .Fil:Writnull���     file�g 0 thefile theFile�f �d�c�
�d 
Data�c 0 thedata theData� �b��
�b 
Type� {�a�`�_�a 0 datatype dataType�`  
�_ 
ctxt� �^��]
�^ 
Enco� {�\�[�Z�\ 0 textencoding textEncoding�[  
�Z FEncFE01�]  � �Y�X�W�V�U�T�S�R�Q�P�O�N�M�L�Y 0 thefile theFile�X 0 thedata theData�W 0 datatype dataType�V 0 textencoding textEncoding�U 0 	posixpath 	posixPath�T 0 
asocstring 
asocString�S 0 
didsucceed 
didSucceed�R 0 theerror theError�Q 0 fh  �P 0 	theresult 	theResult�O 0 etext eText�N 0 enumber eNumber�M 0 efrom eFrom�L 
0 eto eTo� '7�KC�J�I�H�G�F�E_�D�C�B�A�@�?�>�=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.��-�,��+�*�K ,0 asposixpathparameter asPOSIXPathParameter�J "0 astypeparameter asTypeParameter
�I 
ctxt
�H FEncFEPE
�G 
bool
�F misccura�E 0 nsstring NSString�D "0 astextparameter asTextParameter�C &0 stringwithstring_ stringWithString_�B 0 getencoding getEncoding
�A 
obj �@ �? P0 &writetofile_atomically_encoding_error_ &writeToFile_atomically_encoding_error_
�> 
cobj
�= 
errn�< 0 code  
�; 
erob
�: 
errt�9 �8 ,0 localizeddescription localizedDescription
�7 
psxf
�6 
perm
�5 .rdwropenshor       file
�4 
set2
�3 .rdwrseofnull���     ****
�2 
refn
�1 
as  
�0 .rdwrwritnull���     ****
�/ .rdwrclosnull���     ****�. 0 etext eText� �)�(�
�) 
errn�( 0 enumber eNumber� �'�&�
�' 
erob�& 0 efrom eFrom� �%�$�#
�% 
errt�$ 
0 eto eTo�#  �-  �,  �+ �* 
0 _error  �e
 �b  ��l+ E�Ob  ��l+ E�O�� 	 ���& i��,b  ��l+ 
k+ E�Ob  �k+ E�O��e���+ E[a k/E�Z[a l/E�ZO� !)a �j+ a �a �a �j+ �&Y hY a�a &a el E�O %�a jl O�a �a �� O�j O�W +X   ! 
�j W X " #hO)a �a �a �a �W X   !*a $����a %+ &v �"��!� ���
�" .Fil:ConPnull���     ****�! 0 filepath filePath�  ���
� 
From� {���� 0 
fromformat 
fromFormat�  
� FLCTFLCP� ���
� 
To__� {���� 0 toformat toFormat�  
� FLCTFLCP�  � 	���������� 0 filepath filePath� 0 
fromformat 
fromFormat� 0 toformat toFormat� 0 	posixpath 	posixPath� 0 asocurl asocURL� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� -���
�	�����G���� ��������������f������m���������������������
�������
� 
kocl
� 
ctxt
�
 .corecnte****       ****�	 ,0 asposixpathparameter asPOSIXPathParameter
� FLCTFLCP
� FLCTFLCH
� 
file
� 
psxp
� FLCTFLCW
� FLCTFLCU
� misccura� 0 nsurl NSURL�   0 urlwithstring_ URLWithString_
�� 
msng�� 0 fileurl fileURL
�� 
bool
�� 
errn���Y
�� 
erob�� 
�� 
errt
�� 
enum�� 
�� 
leng
�� FLCTFLCA
�� 
psxf
�� 
alis
�� FLCTFLCX
�� FLCTFLCS
�� 
ascr�� $0 fileurlwithpath_ fileURLWithPath_��  0 absolutestring absoluteString�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  ����kv��l j  b  ��l+ E�Y ���  �E�Y u��  *�/�,E�Y d��  	)j�Y W��  9��,�k+ E�O�� 
 �j+ a & )a a a �a a Y hY )a a a �a a a a O�a ,j  )a a a �a a Y hO��  �Y ��a   �a &a &Y ��a    �a &Y ��a !  _ "�a &�&/Y u��  �a &�&Y d��  )ja #Y U��  7��,�k+ $E�O��  )a a a �a a %�%Y hO�j+ &�&Y )a a a �a a a a 'W X ( )*a *����a ++ ,w ��,��������
�� .Fil:NorPnull���     ****�� 0 filepath filePath��  � ������������ 0 filepath filePath�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� <���������������V������ ,0 asposixpathparameter asPOSIXPathParameter
�� misccura�� 0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� 60 stringbystandardizingpath stringByStandardizingPath
�� 
ctxt�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� 3 "b  ��l+ E�O��,�k+ j+ �&W X  *顢���+ x ��f��������
�� .Fil:JoiPnull���     ****��  0 pathcomponents pathComponents�� �����
�� 
Exte� {�������� 0 fileextension fileExtension��  
�� 
msng��  � 	��������������������  0 pathcomponents pathComponents�� 0 fileextension fileExtension�� 0 subpaths subPaths�� 0 aref aRef�� 0 asocpath asocPath�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� }���������������������������������������������������� "0 aslistparameter asListParameter
�� 
cobj
�� 
kocl
�� .corecnte****       ****
�� 
pcnt�� ,0 asposixpathparameter asPOSIXPathParameter��  ��  
�� 
errn���Y
�� 
erob�� 
�� misccura�� 0 nsstring NSString�� *0 pathwithcomponents_ pathWithComponents_
�� 
msng�� "0 astextparameter asTextParameter�� B0 stringbyappendingpathextension_ stringByAppendingPathExtension_
�� 
ctxt�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� � �b  ��l+ �-E�O ;�jv  	)jhY hO %�[��l kh b  ��,�l+ ��,F[OY��W X  	)�����O�a ,�k+ E�O�a  4b  �a l+ E�O��k+ E�O�a   )����a Y hY hO�a &W X  *a ����a + y �����������
�� .Fil:SplPnull���     ctxt�� 0 filepath filePath�� �����
�� 
Upon� {�������� 0 splitposition splitPosition��  
�� FLSPFLSL��  � ������������������ 0 filepath filePath�� 0 splitposition splitPosition�� 0 asocpath asocPath�� 0 matchformat matchFormat�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ����������������������~�}�|�{�z�y�x�w�vR�u�c�t�s
�� misccura�� 0 nsstring NSString�� ,0 asposixpathparameter asPOSIXPathParameter�� &0 stringwithstring_ stringWithString_
�� FLSPFLSL�� F0 !stringbydeletinglastpathcomponent !stringByDeletingLastPathComponent
�� 
ctxt�� &0 lastpathcomponent lastPathComponent
�� FLSPFLSE�� >0 stringbydeletingpathextension stringByDeletingPathExtension� 0 pathextension pathExtension
�~ FLSPFLSA�}  0 pathcomponents pathComponents
�| 
list
�{ 
errn�z�Y
�y 
erob
�x 
errt
�w 
enum�v �u 0 etext eText� �r�q�
�r 
errn�q 0 enumber eNumber� �p�o�
�p 
erob�o 0 efrom eFrom� �n�m�l
�n 
errt�m 
0 eto eTo�l  �t �s 
0 _error  �� � u��,b  ��l+ k+ E�O��  �j+ �&�j+ �&lvY C��  �j+ 
�&�j+ �&lvY )��  �j+ �&Y )�a a �a a a a W X  *a ����a + ascr  ��ޭ
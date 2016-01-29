FasdUAS 1.101.10   ��   ��    k             l      ��  ��    TextLib -- commonly-used text processing commands

Caution: When matching text item delimiters in text value, AppleScript uses the current scope's existing considering/ignoring case, diacriticals, hyphens, punctuation, white space and numeric strings settings; thus, wrapping a `search text` command in different considering/ignoring blocks can produce different results. For example, `search text "fud" for "F" will normally match the first character since AppleScript uses case-insensitive matching by default, whereas enclosing it in a `considering case` block will cause the same command to return zero matches. Conversely, `search text "f ud" for "fu"` will normally return zero matches as AppleScript considers white space by default, but when enclosed in an `ignoring white space` block will match the first three characters: "f u". This is how AppleScript is designed to work, but users need to be reminded of this as considering/ignoring blocks affect ALL script handlers called within that block, including nested calls (and all to any osax and application handlers that understand considering/ignoring attributes). (A much safer design would've restricted considering/ignoring blocks effect to their lexical scope by default; individual handlers would then using standard considering/ignoring behavior by default unless they use a `considering current options` block to indicate that the calling code's current considering/ignoring options should be used.)

TO DO:

- what about Unicode normalization when searching/comparing NSStrings? or does NSString/NSRegularExpression deal with that already? (i.e. are there any current use cases where explicit NSString normalization is required? probably not, but best confirm)

- decide if predefined considering/ignoring options in `search text`, etc. should consider or ignore diacriticals and numeric strings; once decided, use same combinations for ListLib's text comparator for consistency

- also provide `exact match` option in `search text`/`split text` that considers case, diacriticals, hyphens, punctuation and white space but ignores numeric strings? currently, the `case insensitivity` and `case sensitivity` options both consider numeric strings (BTW, it might be better to replace `case sensitivity` with `exact match` to avoid having too many confusing options); also check just how much `considering numeric strings` affects matching (as opposed to ordering, which is its real intention)

- to normalize text theText using normalizationForm -- Q. how does AS normally deal with composed vs decomposed unicode chars? (will need to run tests to determine); note that Satimage.osax provides a `normalize unicode` command, although it only covers 2 of 4 forms (most likely KD and KC) -- TO DO: use `precomposed characters` and `compatibility mapping` boolean params? (also, need to figure out which is preferred form to use as default)
		decomposedStringWithCanonicalMapping (Unicode Normalization Form D)
		decomposedStringWithCompatibilityMapping (Unicode Normalization Form KD)
		precomposedStringWithCanonicalMapping (Unicode Normalization Form C)
		precomposedStringWithCompatibilityMapping (Unicode Normalization Form KC)



- `insert into text`, `delete from text` for inserting/replacing/deleting ranges of characters (c.f. `insert into list`, `delete from list` in ListLib)


- add `matching first item only` boolean option to `search text` (this allows users to perform incremental matching fairly efficiently without having to use an Iterator API)

- also allow `search text` handler's `replacing with` parameter to accept a script object containing a `replacementText` handler; this would take the match record produced by _findText()/_findPattern() and return the text to insert; useful when the replacement text is based on the original, e.g. when uppercasing matched text the user currently has to get a list of match records from `search text`, then iterate over it and replace each text range herself


- would it be worth implementing a `compare text` command that allows considering/ignoring options to be supplied as `considering`/`ignoring` parameters (considering/ignoring blocks can't be parameterized as they require hardcoded constants) as this would allow comparisons to be safely performed without having to futz with considering/ignoring blocks all the time (c.f. MathLib's `compare number`); for extra flexibility, the comparator constructor should also be exposed as a public command, and the returned object implement the same `makeKey`+`compareItems` methods as ListLib's sort comparators, allowing them to be used interchangeably (one could even argue for putting all comparators into their own lib, which other libraries and user scripts can import whenever they need to parameterize comparison behavior)

- Q. what difference does locale make to uppercase/capitalize/lowercase text?

- what, if any, additional localization info (via NSLocale) might be relevant/useful to AS users?



- not sure about formatting type class and symbol constants in `literal representation` (IIRC, AS only binds application info to reference objects, not type/constant objects, in which case only terms defined in AS's own dictionary will format as keywords and the rest will format using raw chevron syntax (though currently even app specifers, which do know app identity, appear as raw syntax)

     � 	 	*
   T e x t L i b   - -   c o m m o n l y - u s e d   t e x t   p r o c e s s i n g   c o m m a n d s 
 
 C a u t i o n :   W h e n   m a t c h i n g   t e x t   i t e m   d e l i m i t e r s   i n   t e x t   v a l u e ,   A p p l e S c r i p t   u s e s   t h e   c u r r e n t   s c o p e ' s   e x i s t i n g   c o n s i d e r i n g / i g n o r i n g   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n ,   w h i t e   s p a c e   a n d   n u m e r i c   s t r i n g s   s e t t i n g s ;   t h u s ,   w r a p p i n g   a   ` s e a r c h   t e x t `   c o m m a n d   i n   d i f f e r e n t   c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n   p r o d u c e   d i f f e r e n t   r e s u l t s .   F o r   e x a m p l e ,   ` s e a r c h   t e x t   " f u d "   f o r   " F "   w i l l   n o r m a l l y   m a t c h   t h e   f i r s t   c h a r a c t e r   s i n c e   A p p l e S c r i p t   u s e s   c a s e - i n s e n s i t i v e   m a t c h i n g   b y   d e f a u l t ,   w h e r e a s   e n c l o s i n g   i t   i n   a   ` c o n s i d e r i n g   c a s e `   b l o c k   w i l l   c a u s e   t h e   s a m e   c o m m a n d   t o   r e t u r n   z e r o   m a t c h e s .   C o n v e r s e l y ,   ` s e a r c h   t e x t   " f   u d "   f o r   " f u " `   w i l l   n o r m a l l y   r e t u r n   z e r o   m a t c h e s   a s   A p p l e S c r i p t   c o n s i d e r s   w h i t e   s p a c e   b y   d e f a u l t ,   b u t   w h e n   e n c l o s e d   i n   a n   ` i g n o r i n g   w h i t e   s p a c e `   b l o c k   w i l l   m a t c h   t h e   f i r s t   t h r e e   c h a r a c t e r s :   " f   u " .   T h i s   i s   h o w   A p p l e S c r i p t   i s   d e s i g n e d   t o   w o r k ,   b u t   u s e r s   n e e d   t o   b e   r e m i n d e d   o f   t h i s   a s   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a f f e c t   A L L   s c r i p t   h a n d l e r s   c a l l e d   w i t h i n   t h a t   b l o c k ,   i n c l u d i n g   n e s t e d   c a l l s   ( a n d   a l l   t o   a n y   o s a x   a n d   a p p l i c a t i o n   h a n d l e r s   t h a t   u n d e r s t a n d   c o n s i d e r i n g / i g n o r i n g   a t t r i b u t e s ) .   ( A   m u c h   s a f e r   d e s i g n   w o u l d ' v e   r e s t r i c t e d   c o n s i d e r i n g / i g n o r i n g   b l o c k s   e f f e c t   t o   t h e i r   l e x i c a l   s c o p e   b y   d e f a u l t ;   i n d i v i d u a l   h a n d l e r s   w o u l d   t h e n   u s i n g   s t a n d a r d   c o n s i d e r i n g / i g n o r i n g   b e h a v i o r   b y   d e f a u l t   u n l e s s   t h e y   u s e   a   ` c o n s i d e r i n g   c u r r e n t   o p t i o n s `   b l o c k   t o   i n d i c a t e   t h a t   t h e   c a l l i n g   c o d e ' s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   s h o u l d   b e   u s e d . ) 
 
 T O   D O : 
 
 -   w h a t   a b o u t   U n i c o d e   n o r m a l i z a t i o n   w h e n   s e a r c h i n g / c o m p a r i n g   N S S t r i n g s ?   o r   d o e s   N S S t r i n g / N S R e g u l a r E x p r e s s i o n   d e a l   w i t h   t h a t   a l r e a d y ?   ( i . e .   a r e   t h e r e   a n y   c u r r e n t   u s e   c a s e s   w h e r e   e x p l i c i t   N S S t r i n g   n o r m a l i z a t i o n   i s   r e q u i r e d ?   p r o b a b l y   n o t ,   b u t   b e s t   c o n f i r m ) 
 
 -   d e c i d e   i f   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   i n   ` s e a r c h   t e x t ` ,   e t c .   s h o u l d   c o n s i d e r   o r   i g n o r e   d i a c r i t i c a l s   a n d   n u m e r i c   s t r i n g s ;   o n c e   d e c i d e d ,   u s e   s a m e   c o m b i n a t i o n s   f o r   L i s t L i b ' s   t e x t   c o m p a r a t o r   f o r   c o n s i s t e n c y 
 
 -   a l s o   p r o v i d e   ` e x a c t   m a t c h `   o p t i o n   i n   ` s e a r c h   t e x t ` / ` s p l i t   t e x t `   t h a t   c o n s i d e r s   c a s e ,   d i a c r i t i c a l s ,   h y p h e n s ,   p u n c t u a t i o n   a n d   w h i t e   s p a c e   b u t   i g n o r e s   n u m e r i c   s t r i n g s ?   c u r r e n t l y ,   t h e   ` c a s e   i n s e n s i t i v i t y `   a n d   ` c a s e   s e n s i t i v i t y `   o p t i o n s   b o t h   c o n s i d e r   n u m e r i c   s t r i n g s   ( B T W ,   i t   m i g h t   b e   b e t t e r   t o   r e p l a c e   ` c a s e   s e n s i t i v i t y `   w i t h   ` e x a c t   m a t c h `   t o   a v o i d   h a v i n g   t o o   m a n y   c o n f u s i n g   o p t i o n s ) ;   a l s o   c h e c k   j u s t   h o w   m u c h   ` c o n s i d e r i n g   n u m e r i c   s t r i n g s `   a f f e c t s   m a t c h i n g   ( a s   o p p o s e d   t o   o r d e r i n g ,   w h i c h   i s   i t s   r e a l   i n t e n t i o n ) 
 
 -   t o   n o r m a l i z e   t e x t   t h e T e x t   u s i n g   n o r m a l i z a t i o n F o r m   - -   Q .   h o w   d o e s   A S   n o r m a l l y   d e a l   w i t h   c o m p o s e d   v s   d e c o m p o s e d   u n i c o d e   c h a r s ?   ( w i l l   n e e d   t o   r u n   t e s t s   t o   d e t e r m i n e ) ;   n o t e   t h a t   S a t i m a g e . o s a x   p r o v i d e s   a   ` n o r m a l i z e   u n i c o d e `   c o m m a n d ,   a l t h o u g h   i t   o n l y   c o v e r s   2   o f   4   f o r m s   ( m o s t   l i k e l y   K D   a n d   K C )   - -   T O   D O :   u s e   ` p r e c o m p o s e d   c h a r a c t e r s `   a n d   ` c o m p a t i b i l i t y   m a p p i n g `   b o o l e a n   p a r a m s ?   ( a l s o ,   n e e d   t o   f i g u r e   o u t   w h i c h   i s   p r e f e r r e d   f o r m   t o   u s e   a s   d e f a u l t ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   D ) 
 	 	 d e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K D ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C a n o n i c a l M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   C ) 
 	 	 p r e c o m p o s e d S t r i n g W i t h C o m p a t i b i l i t y M a p p i n g   ( U n i c o d e   N o r m a l i z a t i o n   F o r m   K C ) 
 
 
 
 -   ` i n s e r t   i n t o   t e x t ` ,   ` d e l e t e   f r o m   t e x t `   f o r   i n s e r t i n g / r e p l a c i n g / d e l e t i n g   r a n g e s   o f   c h a r a c t e r s   ( c . f .   ` i n s e r t   i n t o   l i s t ` ,   ` d e l e t e   f r o m   l i s t `   i n   L i s t L i b ) 
 
 
 -   a d d   ` m a t c h i n g   f i r s t   i t e m   o n l y `   b o o l e a n   o p t i o n   t o   ` s e a r c h   t e x t `   ( t h i s   a l l o w s   u s e r s   t o   p e r f o r m   i n c r e m e n t a l   m a t c h i n g   f a i r l y   e f f i c i e n t l y   w i t h o u t   h a v i n g   t o   u s e   a n   I t e r a t o r   A P I ) 
 
 -   a l s o   a l l o w   ` s e a r c h   t e x t `   h a n d l e r ' s   ` r e p l a c i n g   w i t h `   p a r a m e t e r   t o   a c c e p t   a   s c r i p t   o b j e c t   c o n t a i n i n g   a   ` r e p l a c e m e n t T e x t `   h a n d l e r ;   t h i s   w o u l d   t a k e   t h e   m a t c h   r e c o r d   p r o d u c e d   b y   _ f i n d T e x t ( ) / _ f i n d P a t t e r n ( )   a n d   r e t u r n   t h e   t e x t   t o   i n s e r t ;   u s e f u l   w h e n   t h e   r e p l a c e m e n t   t e x t   i s   b a s e d   o n   t h e   o r i g i n a l ,   e . g .   w h e n   u p p e r c a s i n g   m a t c h e d   t e x t   t h e   u s e r   c u r r e n t l y   h a s   t o   g e t   a   l i s t   o f   m a t c h   r e c o r d s   f r o m   ` s e a r c h   t e x t ` ,   t h e n   i t e r a t e   o v e r   i t   a n d   r e p l a c e   e a c h   t e x t   r a n g e   h e r s e l f 
 
 
 -   w o u l d   i t   b e   w o r t h   i m p l e m e n t i n g   a   ` c o m p a r e   t e x t `   c o m m a n d   t h a t   a l l o w s   c o n s i d e r i n g / i g n o r i n g   o p t i o n s   t o   b e   s u p p l i e d   a s   ` c o n s i d e r i n g ` / ` i g n o r i n g `   p a r a m e t e r s   ( c o n s i d e r i n g / i g n o r i n g   b l o c k s   c a n ' t   b e   p a r a m e t e r i z e d   a s   t h e y   r e q u i r e   h a r d c o d e d   c o n s t a n t s )   a s   t h i s   w o u l d   a l l o w   c o m p a r i s o n s   t o   b e   s a f e l y   p e r f o r m e d   w i t h o u t   h a v i n g   t o   f u t z   w i t h   c o n s i d e r i n g / i g n o r i n g   b l o c k s   a l l   t h e   t i m e   ( c . f .   M a t h L i b ' s   ` c o m p a r e   n u m b e r ` ) ;   f o r   e x t r a   f l e x i b i l i t y ,   t h e   c o m p a r a t o r   c o n s t r u c t o r   s h o u l d   a l s o   b e   e x p o s e d   a s   a   p u b l i c   c o m m a n d ,   a n d   t h e   r e t u r n e d   o b j e c t   i m p l e m e n t   t h e   s a m e   ` m a k e K e y ` + ` c o m p a r e I t e m s `   m e t h o d s   a s   L i s t L i b ' s   s o r t   c o m p a r a t o r s ,   a l l o w i n g   t h e m   t o   b e   u s e d   i n t e r c h a n g e a b l y   ( o n e   c o u l d   e v e n   a r g u e   f o r   p u t t i n g   a l l   c o m p a r a t o r s   i n t o   t h e i r   o w n   l i b ,   w h i c h   o t h e r   l i b r a r i e s   a n d   u s e r   s c r i p t s   c a n   i m p o r t   w h e n e v e r   t h e y   n e e d   t o   p a r a m e t e r i z e   c o m p a r i s o n   b e h a v i o r ) 
 
 -   Q .   w h a t   d i f f e r e n c e   d o e s   l o c a l e   m a k e   t o   u p p e r c a s e / c a p i t a l i z e / l o w e r c a s e   t e x t ? 
 
 -   w h a t ,   i f   a n y ,   a d d i t i o n a l   l o c a l i z a t i o n   i n f o   ( v i a   N S L o c a l e )   m i g h t   b e   r e l e v a n t / u s e f u l   t o   A S   u s e r s ? 
 
 
 
 -   n o t   s u r e   a b o u t   f o r m a t t i n g   t y p e   c l a s s   a n d   s y m b o l   c o n s t a n t s   i n   ` l i t e r a l   r e p r e s e n t a t i o n `   ( I I R C ,   A S   o n l y   b i n d s   a p p l i c a t i o n   i n f o   t o   r e f e r e n c e   o b j e c t s ,   n o t   t y p e / c o n s t a n t   o b j e c t s ,   i n   w h i c h   c a s e   o n l y   t e r m s   d e f i n e d   i n   A S ' s   o w n   d i c t i o n a r y   w i l l   f o r m a t   a s   k e y w o r d s   a n d   t h e   r e s t   w i l l   f o r m a t   u s i n g   r a w   c h e v r o n   s y n t a x   ( t h o u g h   c u r r e n t l y   e v e n   a p p   s p e c i f e r s ,   w h i c h   d o   k n o w   a p p   i d e n t i t y ,   a p p e a r   a s   r a w   s y n t a x ) 
 
   
  
 l     ��������  ��  ��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        l     ��������  ��  ��        l     ��������  ��  ��        j    �� �� 60 _textsupportagentbundleid _TextSupportAgentBundleID  m       �   d c o m . a p p l e . S c r i p t E d i t o r . i d . l i b r a r y . T e x t . T e x t S u p p o r t      l     ��������  ��  ��        l     ��������  ��  ��         l     �� ! "��   ! J D--------------------------------------------------------------------    " � # # � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -    $ % $ l     �� & '��   &   record types    ' � ( (    r e c o r d   t y p e s %  ) * ) l     ��������  ��  ��   *  + , + j    �� -�� (0 _unmatchedtexttype _UnmatchedTextType - m    ��
�� 
TxtU ,  . / . j    �� 0�� $0 _matchedtexttype _MatchedTextType 0 m    ��
�� 
TxtM /  1 2 1 j    �� 3�� &0 _matchedgrouptype _MatchedGroupType 3 m    ��
�� 
TxtG 2  4 5 4 l     ��������  ��  ��   5  6 7 6 l     ��������  ��  ��   7  8 9 8 l     �� : ;��   : J D--------------------------------------------------------------------    ; � < < � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 9  = > = l     �� ? @��   ?   support    @ � A A    s u p p o r t >  B C B l     ��������  ��  ��   C  D E D l      F G H F j    �� I�� 0 _supportlib _supportLib I N     J J 4    �� K
�� 
scpt K m     L L � M M " L i b r a r y S u p p o r t L i b G "  used for parameter checking    H � N N 8   u s e d   f o r   p a r a m e t e r   c h e c k i n g E  O P O l     ��������  ��  ��   P  Q R Q l     ��������  ��  ��   R  S T S i   ! U V U I      �� W���� 
0 _error   W  X Y X o      ���� 0 handlername handlerName Y  Z [ Z o      ���� 0 etext eText [  \ ] \ o      ���� 0 enumber eNumber ]  ^ _ ^ o      ���� 0 efrom eFrom _  `�� ` o      ���� 
0 eto eTo��  ��   V n     a b a I    �� c���� &0 throwcommanderror throwCommandError c  d e d m     f f � g g  T e x t L i b e  h i h o    ���� 0 handlername handlerName i  j k j o    ���� 0 etext eText k  l m l o    	���� 0 enumber eNumber m  n o n o   	 
���� 0 efrom eFrom o  p�� p o   
 ���� 
0 eto eTo��  ��   b o     ���� 0 _supportlib _supportLib T  q r q l     ��������  ��  ��   r  s t s l     ��������  ��  ��   t  u v u l     �� w x��   w J D--------------------------------------------------------------------    x � y y � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - v  z { z l     �� | }��   |   Find and Replace Suite    } � ~ ~ .   F i n d   a n d   R e p l a c e   S u i t e {   �  l     ��������  ��  ��   �  � � � i  " % � � � I      �� ����� 60 _compileregularexpression _compileRegularExpression �  ��� � o      ���� 0 patterntext patternText��  ��   � k     " � �  � � � r      � � � n    
 � � � I    
�� ����� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_ �  � � � o    ���� 0 patterntext patternText �  � � � m    ����   �  ��� � l    ����� � m    ��
�� 
msng��  ��  ��  ��   � n     � � � o    ���� *0 nsregularexpression NSRegularExpression � m     ��
�� misccura � o      ���� 
0 regexp   �  � � � Z    � ����� � =    � � � o    ���� 
0 regexp   � m    ��
�� 
msng � R    �� � �
�� .ascrerr ****      � **** � m     � � � � � \ I n v a l i d    f o r    p a r a m e t e r   ( n o t   a   v a l i d   p a t t e r n ) . � �� � �
�� 
errn � m    �����Y � �� ���
�� 
erob � o    ���� 0 patterntext patternText��  ��  ��   �  ��� � L     " � � o     !���� 
0 regexp  ��   �  � � � l     ��������  ��  ��   �  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   find pattern    � � � �    f i n d   p a t t e r n �  � � � l     ��������  ��  ��   �  � � � i  & ) � � � I      �� ����� $0 _matchinforecord _matchInfoRecord �  � � � o      ���� 0 
asocstring 
asocString �  � � � o      ����  0 asocmatchrange asocMatchRange �  � � � o      ���� 0 
textoffset 
textOffset �  ��� � o      ���� 0 
recordtype 
recordType��  ��   � k     # � �  � � � r     
 � � � c      � � � l     ����� � n     � � � I    �� ����� *0 substringwithrange_ substringWithRange_ �  ��� � o    ��  0 asocmatchrange asocMatchRange��  ��   � o     �~�~ 0 
asocstring 
asocString��  ��   � m    �}
�} 
ctxt � o      �|�| 0 	foundtext 	foundText �  � � � l    � � � � r     � � � [     � � � o    �{�{ 0 
textoffset 
textOffset � l    ��z�y � n     � � � 1    �x
�x 
leng � o    �w�w 0 	foundtext 	foundText�z  �y   � o      �v�v  0 nexttextoffset nextTextOffset � : 4 calculate the start index of the next AS text range    � � � � h   c a l c u l a t e   t h e   s t a r t   i n d e x   o f   t h e   n e x t   A S   t e x t   r a n g e �  � � � l   �u � ��u   �
 note: record keys are identifiers, not keywords, as 1. library-defined keywords are a huge pain to use outside of `tell script...` blocks and 2. importing the library's terminology into the global namespace via `use script...` is an excellent way to create keyword conflicts; only the class value is a keyword since Script Editor/OSAKit don't correctly handle records that use non-typename values (e.g. `{class:"matched text",...}`), but this shouldn't impact usability as it's really only used for informational purposes    � � � �   n o t e :   r e c o r d   k e y s   a r e   i d e n t i f i e r s ,   n o t   k e y w o r d s ,   a s   1 .   l i b r a r y - d e f i n e d   k e y w o r d s   a r e   a   h u g e   p a i n   t o   u s e   o u t s i d e   o f   ` t e l l   s c r i p t . . . `   b l o c k s   a n d   2 .   i m p o r t i n g   t h e   l i b r a r y ' s   t e r m i n o l o g y   i n t o   t h e   g l o b a l   n a m e s p a c e   v i a   ` u s e   s c r i p t . . . `   i s   a n   e x c e l l e n t   w a y   t o   c r e a t e   k e y w o r d   c o n f l i c t s ;   o n l y   t h e   c l a s s   v a l u e   i s   a   k e y w o r d   s i n c e   S c r i p t   E d i t o r / O S A K i t   d o n ' t   c o r r e c t l y   h a n d l e   r e c o r d s   t h a t   u s e   n o n - t y p e n a m e   v a l u e s   ( e . g .   ` { c l a s s : " m a t c h e d   t e x t " , . . . } ` ) ,   b u t   t h i s   s h o u l d n ' t   i m p a c t   u s a b i l i t y   a s   i t ' s   r e a l l y   o n l y   u s e d   f o r   i n f o r m a t i o n a l   p u r p o s e s �  ��t � l   # � � � � L    # � � J    " � �  � � � K     � � �s � �
�s 
pcls � o    �r�r 0 
recordtype 
recordType � �q � ��q 0 
startindex 
startIndex � o    �p�p 0 
textoffset 
textOffset � �o � ��o 0 endindex endIndex � \     � � � o    �n�n  0 nexttextoffset nextTextOffset � m    �m�m  � �l ��k�l 0 	foundtext 	foundText � o    �j�j 0 	foundtext 	foundText�k   �  ��i � o     �h�h  0 nexttextoffset nextTextOffset�i   �  y TO DO: use fromIndex/toIndex instead of startIndex/endIndex? (see also ListLib; consistent naming would be good to have)    � � � � �   T O   D O :   u s e   f r o m I n d e x / t o I n d e x   i n s t e a d   o f   s t a r t I n d e x / e n d I n d e x ?   ( s e e   a l s o   L i s t L i b ;   c o n s i s t e n t   n a m i n g   w o u l d   b e   g o o d   t o   h a v e )�t   �  � � � l     �g�f�e�g  �f  �e   �  � � � l     �d�c�b�d  �c  �b   �  � � � i  * - � � � I      �a ��`�a 0 _matchrecords _matchRecords �  � � � o      �_�_ 0 
asocstring 
asocString �  � � � o      �^�^  0 asocmatchrange asocMatchRange �  � � � o      �]�]  0 asocstartindex asocStartIndex �  � � � o      �\�\ 0 
textoffset 
textOffset �    o      �[�[ (0 nonmatchrecordtype nonMatchRecordType �Z o      �Y�Y "0 matchrecordtype matchRecordType�Z  �`   � k     V  l     �X�X   � � important: NSString character indexes aren't guaranteed to be same as AS character indexes, so reconstruct both non-matching and matching AS text values, and calculate accurate AS character ranges from those    ��   i m p o r t a n t :   N S S t r i n g   c h a r a c t e r   i n d e x e s   a r e n ' t   g u a r a n t e e d   t o   b e   s a m e   a s   A S   c h a r a c t e r   i n d e x e s ,   s o   r e c o n s t r u c t   b o t h   n o n - m a t c h i n g   a n d   m a t c h i n g   A S   t e x t   v a l u e s ,   a n d   c a l c u l a t e   a c c u r a t e   A S   c h a r a c t e r   r a n g e s   f r o m   t h o s e 	
	 r      n     I    �W�V�U�W 0 location  �V  �U   o     �T�T  0 asocmatchrange asocMatchRange o      �S�S  0 asocmatchstart asocMatchStart
  r     [     o    	�R�R  0 asocmatchstart asocMatchStart l  	 �Q�P n  	  I   
 �O�N�M�O 
0 length  �N  �M   o   	 
�L�L  0 asocmatchrange asocMatchRange�Q  �P   o      �K�K 0 asocmatchend asocMatchEnd  r     K     �J�J 0 location   o    �I�I  0 asocstartindex asocStartIndex �H�G�H 
0 length   \     !  o    �F�F  0 asocmatchstart asocMatchStart! o    �E�E  0 asocstartindex asocStartIndex�G   o      �D�D &0 asocnonmatchrange asocNonMatchRange "#" r    5$%$ I      �C&�B�C $0 _matchinforecord _matchInfoRecord& '(' o    �A�A 0 
asocstring 
asocString( )*) o     �@�@ &0 asocnonmatchrange asocNonMatchRange* +,+ o     !�?�? 0 
textoffset 
textOffset, -�>- o   ! "�=�= (0 nonmatchrecordtype nonMatchRecordType�>  �B  % J      .. /0/ o      �<�< 0 nonmatchinfo nonMatchInfo0 1�;1 o      �:�: 0 
textoffset 
textOffset�;  # 232 r   6 N454 I      �96�8�9 $0 _matchinforecord _matchInfoRecord6 787 o   7 8�7�7 0 
asocstring 
asocString8 9:9 o   8 9�6�6  0 asocmatchrange asocMatchRange: ;<; o   9 :�5�5 0 
textoffset 
textOffset< =�4= o   : ;�3�3 "0 matchrecordtype matchRecordType�4  �8  5 J      >> ?@? o      �2�2 0 	matchinfo 	matchInfo@ A�1A o      �0�0 0 
textoffset 
textOffset�1  3 B�/B L   O VCC J   O UDD EFE o   O P�.�. 0 nonmatchinfo nonMatchInfoF GHG o   P Q�-�- 0 	matchinfo 	matchInfoH IJI o   Q R�,�, 0 asocmatchend asocMatchEndJ K�+K o   R S�*�* 0 
textoffset 
textOffset�+  �/   � LML l     �)�(�'�)  �(  �'  M NON l     �&�%�$�&  �%  �$  O PQP i  . 1RSR I      �#T�"�# &0 _matchedgrouplist _matchedGroupListT UVU o      �!�! 0 
asocstring 
asocStringV WXW o      � �  0 	asocmatch 	asocMatchX YZY o      �� 0 
textoffset 
textOffsetZ [�[ o      �� &0 includenonmatches includeNonMatches�  �"  S k     �\\ ]^] r     _`_ J     ��  ` o      �� "0 submatchresults subMatchResults^ aba r    cdc \    efe l   
g��g n   
hih I    
����  0 numberofranges numberOfRanges�  �  i o    �� 0 	asocmatch 	asocMatch�  �  f m   
 �� d o      �� 0 groupindexes groupIndexesb jkj Z    �lm��l ?    non o    �� 0 groupindexes groupIndexeso m    ��  m k    �pp qrq r    sts n   uvu I    �w�� 0 rangeatindex_ rangeAtIndex_w x�x m    ��  �  �  v o    �
�
 0 	asocmatch 	asocMatcht o      �	�	 (0 asocfullmatchrange asocFullMatchRanger yzy r    %{|{ n   #}~} I    #���� 0 location  �  �  ~ o    �� (0 asocfullmatchrange asocFullMatchRange| o      �� &0 asocnonmatchstart asocNonMatchStartz � r   & /��� [   & -��� o   & '�� &0 asocnonmatchstart asocNonMatchStart� l  ' ,���� n  ' ,��� I   ( ,� �����  
0 length  ��  ��  � o   ' (���� (0 asocfullmatchrange asocFullMatchRange�  �  � o      ���� $0 asocfullmatchend asocFullMatchEnd� ��� Y   0 ��������� k   : ��� ��� r   : o��� I      ������� 0 _matchrecords _matchRecords� ��� o   ; <���� 0 
asocstring 
asocString� ��� n  < B��� I   = B������� 0 rangeatindex_ rangeAtIndex_� ���� o   = >���� 0 i  ��  ��  � o   < =���� 0 	asocmatch 	asocMatch� ��� o   B C���� &0 asocnonmatchstart asocNonMatchStart� ��� o   C D���� 0 
textoffset 
textOffset� ��� o   D I���� (0 _unmatchedtexttype _UnmatchedTextType� ���� o   I N���� &0 _matchedgrouptype _MatchedGroupType��  ��  � J      �� ��� o      ���� 0 nonmatchinfo nonMatchInfo� ��� o      ���� 0 	matchinfo 	matchInfo� ��� o      ���� &0 asocnonmatchstart asocNonMatchStart� ���� o      ���� 0 
textoffset 
textOffset��  � ��� Z  p |������� o   p q���� &0 includenonmatches includeNonMatches� r   t x��� o   t u���� 0 nonmatchinfo nonMatchInfo� n      ���  ;   v w� o   u v���� "0 submatchresults subMatchResults��  ��  � ���� r   } ���� o   } ~���� 0 	matchinfo 	matchInfo� n      ���  ;    �� o   ~ ���� "0 submatchresults subMatchResults��  �� 0 i  � m   3 4���� � o   4 5���� 0 groupindexes groupIndexes��  � ���� Z   � �������� o   � ����� &0 includenonmatches includeNonMatches� k   � ��� ��� r   � ���� K   � ��� ������ 0 location  � o   � ����� &0 asocnonmatchstart asocNonMatchStart� ������� 
0 length  � \   � ���� o   � ����� $0 asocfullmatchend asocFullMatchEnd� o   � ����� &0 asocnonmatchstart asocNonMatchStart��  � o      ���� &0 asocnonmatchrange asocNonMatchRange� ���� r   � ���� n   � ���� 4   � ����
�� 
cobj� m   � ����� � I   � �������� $0 _matchinforecord _matchInfoRecord� ��� o   � ����� 0 
asocstring 
asocString� ��� o   � ����� &0 asocnonmatchrange asocNonMatchRange� ��� o   � ����� 0 
textoffset 
textOffset� ���� o   � ����� (0 _unmatchedtexttype _UnmatchedTextType��  ��  � n      ���  ;   � �� o   � ����� "0 submatchresults subMatchResults��  ��  ��  ��  �  �  k ���� L   � ��� o   � ����� "0 submatchresults subMatchResults��  Q ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  2 5��� I      ������� 0 _findpattern _findPattern� ��� o      ���� 0 thetext theText� ��� o      ���� 0 patterntext patternText� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � k    �� ��� r     ��� n    ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ���� &0 includenonmatches includeNonMatches� ���� m    �� ���  u n m a t c h e d   t e x t��  ��  � o     ���� 0 _supportlib _supportLib� o      ���� &0 includenonmatches includeNonMatches� ��� r    ��� n   ��� I    ������� (0 asbooleanparameter asBooleanParameter� ��� o    ����  0 includematches includeMatches� ���� m       �  m a t c h e d   t e x t��  ��  � o    ���� 0 _supportlib _supportLib� o      ����  0 includematches includeMatches�  r    $ I    "������ 60 _compileregularexpression _compileRegularExpression �� o    ���� 0 patterntext patternText��  ��   o      ���� 
0 regexp   	 r   % /

 n  % - I   ( -������ &0 stringwithstring_ stringWithString_ �� o   ( )���� 0 thetext theText��  ��   n  % ( o   & (���� 0 nsstring NSString m   % &��
�� misccura o      ���� 0 
asocstring 
asocString	  l  0 3 r   0 3 m   0 1����   o      ���� &0 asocnonmatchstart asocNonMatchStart G A used to calculate NSRanges for non-matching portions of NSString    � �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g  l  4 7 r   4 7  m   4 5����   o      ���� 0 
textoffset 
textOffset B < used to calculate correct AppleScript start and end indexes    �!! x   u s e d   t o   c a l c u l a t e   c o r r e c t   A p p l e S c r i p t   s t a r t   a n d   e n d   i n d e x e s "#" r   8 <$%$ J   8 :����  % o      ���� 0 
resultlist 
resultList# &'& l  = =��()��  ( @ : iterate over each non-matched + matched range in NSString   ) �** t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g' +,+ r   = N-.- n  = L/0/ I   > L��1���� @0 matchesinstring_options_range_ matchesInString_options_range_1 232 o   > ?���� 0 
asocstring 
asocString3 454 m   ? @����  5 6��6 J   @ H77 898 m   @ A����  9 :��: n  A F;<; I   B F�������� 
0 length  ��  ��  < o   A B���� 0 
asocstring 
asocString��  ��  ��  0 o   = >���� 
0 regexp  . o      ����  0 asocmatcharray asocMatchArray, =>= Y   O �?��@A��? k   _ �BB CDC r   _ gEFE l  _ eG����G n  _ eHIH I   ` e��J����  0 objectatindex_ objectAtIndex_J K��K o   ` a���� 0 i  ��  ��  I o   _ `����  0 asocmatcharray asocMatchArray��  ��  F o      ���� 0 	asocmatch 	asocMatchD LML l  h h�NO�  N � � the first range in match identifies the text matched by the entire pattern, so generate records for full match and its preceding (unmatched) text   O �PP$   t h e   f i r s t   r a n g e   i n   m a t c h   i d e n t i f i e s   t h e   t e x t   m a t c h e d   b y   t h e   e n t i r e   p a t t e r n ,   s o   g e n e r a t e   r e c o r d s   f o r   f u l l   m a t c h   a n d   i t s   p r e c e d i n g   ( u n m a t c h e d )   t e x tM QRQ r   h �STS I      �~U�}�~ 0 _matchrecords _matchRecordsU VWV o   i j�|�| 0 
asocstring 
asocStringW XYX n  j pZ[Z I   k p�{\�z�{ 0 rangeatindex_ rangeAtIndex_\ ]�y] m   k l�x�x  �y  �z  [ o   j k�w�w 0 	asocmatch 	asocMatchY ^_^ o   p q�v�v &0 asocnonmatchstart asocNonMatchStart_ `a` o   q r�u�u 0 
textoffset 
textOffseta bcb o   r w�t�t (0 _unmatchedtexttype _UnmatchedTextTypec d�sd o   w |�r�r $0 _matchedtexttype _MatchedTextType�s  �}  T J      ee fgf o      �q�q 0 nonmatchinfo nonMatchInfog hih o      �p�p 0 	matchinfo 	matchInfoi jkj o      �o�o &0 asocnonmatchstart asocNonMatchStartk l�nl o      �m�m 0 
textoffset 
textOffset�n  R mnm Z  � �op�l�ko o   � ��j�j &0 includenonmatches includeNonMatchesp r   � �qrq o   � ��i�i 0 nonmatchinfo nonMatchInfor n      sts  ;   � �t o   � ��h�h 0 
resultlist 
resultList�l  �k  n u�gu Z   � �vw�f�ev o   � ��d�d  0 includematches includeMatchesw k   � �xx yzy l  � ��c{|�c  { any additional ranges in match identify text matched by group references within regexp pattern, e.g. "([0-9]{4})-([0-9]{2})-([0-9]{2})" will match `YYYY-MM-DD` style date strings, returning the entire text match, plus sub-matches representing year, month and day text   | �}}   a n y   a d d i t i o n a l   r a n g e s   i n   m a t c h   i d e n t i f y   t e x t   m a t c h e d   b y   g r o u p   r e f e r e n c e s   w i t h i n   r e g e x p   p a t t e r n ,   e . g .   " ( [ 0 - 9 ] { 4 } ) - ( [ 0 - 9 ] { 2 } ) - ( [ 0 - 9 ] { 2 } ) "   w i l l   m a t c h   ` Y Y Y Y - M M - D D `   s t y l e   d a t e   s t r i n g s ,   r e t u r n i n g   t h e   e n t i r e   t e x t   m a t c h ,   p l u s   s u b - m a t c h e s   r e p r e s e n t i n g   y e a r ,   m o n t h   a n d   d a y   t e x tz ~�b~ r   � �� b   � ���� o   � ��a�a 0 	matchinfo 	matchInfo� K   � ��� �`��_�` 0 foundgroups foundGroups� I   � ��^��]�^ &0 _matchedgrouplist _matchedGroupList� ��� o   � ��\�\ 0 
asocstring 
asocString� ��� o   � ��[�[ 0 	asocmatch 	asocMatch� ��� n  � ���� o   � ��Z�Z 0 
startindex 
startIndex� o   � ��Y�Y 0 	matchinfo 	matchInfo� ��X� o   � ��W�W &0 includenonmatches includeNonMatches�X  �]  �_  � n      ���  ;   � �� o   � ��V�V 0 
resultlist 
resultList�b  �f  �e  �g  �� 0 i  @ m   R S�U�U  A \   S Z��� l  S X��T�S� n  S X��� I   T X�R�Q�P�R 	0 count  �Q  �P  � o   S T�O�O  0 asocmatcharray asocMatchArray�T  �S  � m   X Y�N�N ��  > ��� l  � ��M���M  � "  add final non-matched range   � ��� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e� ��� Z   ����L�K� o   � ��J�J &0 includenonmatches includeNonMatches� k   � �� ��� r   � ���� c   � ���� l  � ���I�H� n  � ���� I   � ��G��F�G *0 substringfromindex_ substringFromIndex_� ��E� o   � ��D�D &0 asocnonmatchstart asocNonMatchStart�E  �F  � o   � ��C�C 0 
asocstring 
asocString�I  �H  � m   � ��B
�B 
ctxt� o      �A�A 0 	foundtext 	foundText� ��@� r   � ��� K   � ��� �?��
�? 
pcls� o   � ��>�> (0 _unmatchedtexttype _UnmatchedTextType� �=���= 0 
startindex 
startIndex� o   � ��<�< 0 
textoffset 
textOffset� �;���; 0 endindex endIndex� n   � ���� 1   � ��:
�: 
leng� o   � ��9�9 0 thetext theText� �8��7�8 0 	foundtext 	foundText� o   � ��6�6 0 	foundtext 	foundText�7  � n      ���  ;   � �� o   � ��5�5 0 
resultlist 
resultList�@  �L  �K  � ��4� L  �� o  �3�3 0 
resultlist 
resultList�4  � ��� l     �2�1�0�2  �1  �0  � ��� l     �/�.�-�/  �.  �-  � ��� l     �,���,  �  -----   � ��� 
 - - - - -� ��� l     �+���+  �   replace pattern   � ���     r e p l a c e   p a t t e r n� ��� l     �*�)�(�*  �)  �(  � ��� i  6 9��� I      �'��&�' "0 _replacepattern _replacePattern� ��� o      �%�% 0 thetext theText� ��� o      �$�$ 0 patterntext patternText� ��#� o      �"�" 0 templatetext templateText�#  �&  � k     %�� ��� r     
��� n    ��� I    �!�� �! &0 stringwithstring_ stringWithString_� ��� o    �� 0 thetext theText�  �   � n    ��� o    �� 0 nsstring NSString� m     �
� misccura� o      �� 0 
asocstring 
asocString� ��� r    ��� I    ���� 60 _compileregularexpression _compileRegularExpression� ��� o    �� 0 patterntext patternText�  �  � o      �� 
0 regexp  � ��� L    %�� n   $��� I    $���� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� ��� o    �� 0 
asocstring 
asocString� ��� m    ��  � ��� J    �� ��� m    ��  � ��� n   ��� I    ���� 
0 length  �  �  � o    �� 0 
asocstring 
asocString�  � ��
� o     �	�	 0 templatetext templateText�
  �  � o    �� 
0 regexp  �  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     �� �  �  -----     � 
 - - - - -�  l     � �     
 find text    �    f i n d   t e x t  l     ��������  ��  ��   	
	 i  : = I      ������ 0 	_findtext 	_findText  o      ���� 0 thetext theText  o      ���� 0 fortext forText  o      ���� &0 includenonmatches includeNonMatches �� o      ����  0 includematches includeMatches��  ��   k    '  l     ����  �� TO DO: is it worth switching to a more efficient algorithim when hypens, punctuation, and white space are all considered and numeric strings ignored (the default)? i.e. given a fixed-length match, the endIndex of a match can be determined using `forText's length + startIndex - 1` instead of measuring the length of all remaining text after `text item i`; will need to implement both approaches and profile them to determine if it makes any significant difference to speed    ��   T O   D O :   i s   i t   w o r t h   s w i t c h i n g   t o   a   m o r e   e f f i c i e n t   a l g o r i t h i m   w h e n   h y p e n s ,   p u n c t u a t i o n ,   a n d   w h i t e   s p a c e   a r e   a l l   c o n s i d e r e d   a n d   n u m e r i c   s t r i n g s   i g n o r e d   ( t h e   d e f a u l t ) ?   i . e .   g i v e n   a   f i x e d - l e n g t h   m a t c h ,   t h e   e n d I n d e x   o f   a   m a t c h   c a n   b e   d e t e r m i n e d   u s i n g   ` f o r T e x t ' s   l e n g t h   +   s t a r t I n d e x   -   1 `   i n s t e a d   o f   m e a s u r i n g   t h e   l e n g t h   o f   a l l   r e m a i n i n g   t e x t   a f t e r   ` t e x t   i t e m   i ` ;   w i l l   n e e d   t o   i m p l e m e n t   b o t h   a p p r o a c h e s   a n d   p r o f i l e   t h e m   t o   d e t e r m i n e   i f   i t   m a k e s   a n y   s i g n i f i c a n t   d i f f e r e n c e   t o   s p e e d  l     ��������  ��  ��    l     ! Z    "#����" =    $%$ o     ���� 0 fortext forText% m    && �''  # R    ��()
�� .ascrerr ****      � ****( m    ** �++ � I n v a l i d    f o r    p a r a m e t e r   ( t e x t   i s   e m p t y ,   o r   o n l y   c o n t a i n s   c h a r a c t e r s   i g n o r e d   b y   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s )) ��,-
�� 
errn, m    	�����Y- ��.��
�� 
erob. o   
 ���� 0 fortext forText��  ��  ��   �� checks if all characters in forText are ignored by current considering/ignoring settings (the alternative would be to return each character as a non-match separated by a zero-length match, but that's probably not what the user intended); note that unlike `aString's length = 0`, which is what library code normally uses to check for empty text, on this occasion we do want to take into account the current considering/ignoring settings so deliberately use `forText is ""` here. For example, when ignoring punctuation, searching for the TID `"!?"` is no different to searching for `""`, because all of its characters are being ignored when comparing the text being searched against the text being searched for. Thus, a simple `forText is ""` test can be used to check in advance if the text contains any matchable characters under the current considering/ignoring settings, and report a meaningful error if not.   ! �//   c h e c k s   i f   a l l   c h a r a c t e r s   i n   f o r T e x t   a r e   i g n o r e d   b y   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   ( t h e   a l t e r n a t i v e   w o u l d   b e   t o   r e t u r n   e a c h   c h a r a c t e r   a s   a   n o n - m a t c h   s e p a r a t e d   b y   a   z e r o - l e n g t h   m a t c h ,   b u t   t h a t ' s   p r o b a b l y   n o t   w h a t   t h e   u s e r   i n t e n d e d ) ;   n o t e   t h a t   u n l i k e   ` a S t r i n g ' s   l e n g t h   =   0 ` ,   w h i c h   i s   w h a t   l i b r a r y   c o d e   n o r m a l l y   u s e s   t o   c h e c k   f o r   e m p t y   t e x t ,   o n   t h i s   o c c a s i o n   w e   d o   w a n t   t o   t a k e   i n t o   a c c o u n t   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   s o   d e l i b e r a t e l y   u s e   ` f o r T e x t   i s   " " `   h e r e .   F o r   e x a m p l e ,   w h e n   i g n o r i n g   p u n c t u a t i o n ,   s e a r c h i n g   f o r   t h e   T I D   ` " ! ? " `   i s   n o   d i f f e r e n t   t o   s e a r c h i n g   f o r   ` " " ` ,   b e c a u s e   a l l   o f   i t s   c h a r a c t e r s   a r e   b e i n g   i g n o r e d   w h e n   c o m p a r i n g   t h e   t e x t   b e i n g   s e a r c h e d   a g a i n s t   t h e   t e x t   b e i n g   s e a r c h e d   f o r .   T h u s ,   a   s i m p l e   ` f o r T e x t   i s   " " `   t e s t   c a n   b e   u s e d   t o   c h e c k   i n   a d v a n c e   i f   t h e   t e x t   c o n t a i n s   a n y   m a t c h a b l e   c h a r a c t e r s   u n d e r   t h e   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   a n d   r e p o r t   a   m e a n i n g f u l   e r r o r   i f   n o t . 010 r    232 J    ����  3 o      ���� 0 
resultlist 
resultList1 454 r    676 n   898 1    ��
�� 
txdl9 1    ��
�� 
ascr7 o      ���� 0 oldtids oldTIDs5 :;: r    #<=< o    ���� 0 fortext forText= n     >?> 1     "��
�� 
txdl? 1     ��
�� 
ascr; @A@ r   $ 'BCB m   $ %���� C o      ���� 0 
startindex 
startIndexA DED r   ( 0FGF n   ( .HIH 1   , .��
�� 
lengI n   ( ,JKJ 4   ) ,��L
�� 
citmL m   * +���� K o   ( )���� 0 thetext theTextG o      ���� 0 endindex endIndexE MNM Z   1 JOP��QO B   1 4RSR o   1 2���� 0 
startindex 
startIndexS o   2 3���� 0 endindex endIndexP r   7 DTUT n   7 BVWV 7  8 B��XY
�� 
ctxtX o   < >���� 0 
startindex 
startIndexY o   ? A���� 0 endindex endIndexW o   7 8���� 0 thetext theTextU o      ���� 0 	foundtext 	foundText��  Q r   G JZ[Z m   G H\\ �]]  [ o      ���� 0 	foundtext 	foundTextN ^_^ Z  K f`a����` o   K L���� &0 includenonmatches includeNonMatchesa r   O bbcb K   O _dd ��ef
�� 
pclse o   P U���� (0 _unmatchedtexttype _UnmatchedTextTypef ��gh�� 0 
startindex 
startIndexg o   V W���� 0 
startindex 
startIndexh ��ij�� 0 endindex endIndexi o   X Y���� 0 endindex endIndexj ��k���� 0 	foundtext 	foundTextk o   Z [���� 0 	foundtext 	foundText��  c n      lml  ;   ` am o   _ `���� 0 
resultlist 
resultList��  ��  _ non Y   gp��qr��p k   wss tut r   w |vwv [   w zxyx o   w x���� 0 endindex endIndexy m   x y���� w o      ���� 0 
startindex 
startIndexu z{z r   } �|}| \   } �~~ l  } ������� n   } ���� 1   ~ ���
�� 
leng� o   } ~���� 0 thetext theText��  ��   l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 7  � �����
�� 
ctxt� l  � ������� 4   � ����
�� 
citm� o   � ����� 0 i  ��  ��  � m   � �������� o   � ����� 0 thetext theText��  ��  } o      ���� 0 endindex endIndex{ ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ��� Z  � �������� o   � �����  0 includematches includeMatches� r   � ���� K   � ��� ����
�� 
pcls� o   � ����� $0 _matchedtexttype _MatchedTextType� ������ 0 
startindex 
startIndex� o   � ����� 0 
startindex 
startIndex� ������ 0 endindex endIndex� o   � ����� 0 endindex endIndex� ������ 0 	foundtext 	foundText� o   � ����� 0 	foundtext 	foundText� ������� 0 foundgroups foundGroups� J   � �����  ��  � n      ���  ;   � �� o   � ����� 0 
resultlist 
resultList��  ��  � ��� r   � ���� [   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 
startindex 
startIndex� ��� r   � ���� \   � ���� [   � ���� o   � ����� 0 
startindex 
startIndex� l  � ������� n   � ���� 1   � ���
�� 
leng� n   � ���� 4   � ����
�� 
citm� o   � ����� 0 i  � o   � ����� 0 thetext theText��  ��  � m   � ����� � o      ���� 0 endindex endIndex� ��� Z   � ������� B   � ���� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� r   � ���� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� o      ���� 0 	foundtext 	foundText��  � r   � ���� m   � ��� ���  � o      ���� 0 	foundtext 	foundText� ���� Z  �������� o   � ��� &0 includenonmatches includeNonMatches� r  ��� K  �� �~��
�~ 
pcls� o  �}�} (0 _unmatchedtexttype _UnmatchedTextType� �|���| 0 
startindex 
startIndex� o  	
�{�{ 0 
startindex 
startIndex� �z���z 0 endindex endIndex� o  �y�y 0 endindex endIndex� �x��w�x 0 	foundtext 	foundText� o  �v�v 0 	foundtext 	foundText�w  � n      ���  ;  � o  �u�u 0 
resultlist 
resultList��  ��  ��  �� 0 i  q m   j k�t�t r I  k r�s��r
�s .corecnte****       ****� n   k n��� 2  l n�q
�q 
citm� o   k l�p�p 0 thetext theText�r  ��  o ��� r  $��� o   �o�o 0 oldtids oldTIDs� n     ��� 1  !#�n
�n 
txdl� 1   !�m
�m 
ascr� ��l� L  %'�� o  %&�k�k 0 
resultlist 
resultList�l  
 ��� l     �j�i�h�j  �i  �h  � ��� l     �g�f�e�g  �f  �e  � ��� l     �d���d  �  -----   � ��� 
 - - - - -� ��� l     �c���c  �   replace text   � ���    r e p l a c e   t e x t� ��� l     �b�a�`�b  �a  �`  � ��� i  > A   I      �_�^�_ 0 _replacetext _replaceText  o      �]�] 0 thetext theText  o      �\�\ 0 fortext forText �[ o      �Z�Z 0 newtext newText�[  �^   k     & 	
	 r      n     1    �Y
�Y 
txdl 1     �X
�X 
ascr o      �W�W 0 oldtids oldTIDs
  r     o    �V�V 0 fortext forText n      1    
�U
�U 
txdl 1    �T
�T 
ascr  l    r     n    2   �S
�S 
citm o    �R�R 0 thetext theText o      �Q�Q 0 	textitems 	textItems J D note: TID-based matching uses current considering/ignoring settings    � �   n o t e :   T I D - b a s e d   m a t c h i n g   u s e s   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s   r    !"! o    �P�P 0 newtext newText" n     #$# 1    �O
�O 
txdl$ 1    �N
�N 
ascr  %&% r    '(' c    )*) o    �M�M 0 	textitems 	textItems* m    �L
�L 
ctxt( o      �K�K 0 
resulttext 
resultText& +,+ r    #-.- o    �J�J 0 oldtids oldTIDs. n     /0/ 1     "�I
�I 
txdl0 1     �H
�H 
ascr, 1�G1 L   $ &22 o   $ %�F�F 0 
resulttext 
resultText�G  � 343 l     �E�D�C�E  �D  �C  4 565 l     �B�A�@�B  �A  �@  6 787 l     �?9:�?  9  -----   : �;; 
 - - - - -8 <=< l     �>�=�<�>  �=  �<  = >?> i  B E@A@ I     �;BC
�; .Txt:Srchnull���     ctxtB o      �:�: 0 thetext theTextC �9DE
�9 
For_D o      �8�8 0 fortext forTextE �7FG
�7 
UsinF |�6�5H�4I�6  �5  H o      �3�3 0 matchformat matchFormat�4  I l 
    J�2�1J l     K�0�/K m      �.
�. SerECmpI�0  �/  �2  �1  G �-LM
�- 
ReplL |�,�+N�*O�,  �+  N o      �)�) 0 newtext newText�*  O l     P�(�'P m      �&
�& 
msng�(  �'  M �%Q�$
�% 
RetuQ |�#�"R�!S�#  �"  R o      � �  0 resultformat resultFormat�!  S l     T��T m      �
� RetEMatT�  �  �$  A Q    �UVWU k   �XX YZY r    [\[ n   ]^] I    �_�� "0 astextparameter asTextParameter_ `a` o    	�� 0 thetext theTexta b�b m   	 
cc �dd  �  �  ^ o    �� 0 _supportlib _supportLib\ o      �� 0 thetext theTextZ efe l   ghig r    jkj n   lml I    �n�� "0 astextparameter asTextParametern opo o    �� 0 fortext forTextp q�q m    rr �ss  f o r�  �  m o    �� 0 _supportlib _supportLibk o      �� 0 fortext forTexth TO DO: when matching with TIDs, optionally accept a list of multiple text values to match? (note:TIDs can do that for free, so it'd just be a case of relaxing restriction on 'for' parameter's type when pattern matching is false to accept a list of text as well); also optionally accept a corresponding list of replacement values for doing mapping? (note that map will need to be O(n) associative list in order to support considering/ignoring, although NSDictionary should be usable when matching case-sensitively)   i �tt   T O   D O :   w h e n   m a t c h i n g   w i t h   T I D s ,   o p t i o n a l l y   a c c e p t   a   l i s t   o f   m u l t i p l e   t e x t   v a l u e s   t o   m a t c h ?   ( n o t e : T I D s   c a n   d o   t h a t   f o r   f r e e ,   s o   i t ' d   j u s t   b e   a   c a s e   o f   r e l a x i n g   r e s t r i c t i o n   o n   ' f o r '   p a r a m e t e r ' s   t y p e   w h e n   p a t t e r n   m a t c h i n g   i s   f a l s e   t o   a c c e p t   a   l i s t   o f   t e x t   a s   w e l l ) ;   a l s o   o p t i o n a l l y   a c c e p t   a   c o r r e s p o n d i n g   l i s t   o f   r e p l a c e m e n t   v a l u e s   f o r   d o i n g   m a p p i n g ?   ( n o t e   t h a t   m a p   w i l l   n e e d   t o   b e   O ( n )   a s s o c i a t i v e   l i s t   i n   o r d e r   t o   s u p p o r t   c o n s i d e r i n g / i g n o r i n g ,   a l t h o u g h   N S D i c t i o n a r y   s h o u l d   b e   u s a b l e   w h e n   m a t c h i n g   c a s e - s e n s i t i v e l y )f uvu Z   3wx��w =    $yzy n    "{|{ 1     "�
� 
leng| o     �� 0 fortext forTextz m   " #��  x R   ' /�}~
� .ascrerr ****      � ****} m   - . ��� t I n v a l i d    f o r    p a r a m e t e r   ( e x p e c t e d   o n e   o r   m o r e   c h a r a c t e r s ) .~ �
��
�
 
errn� m   ) *�	�	�Y� ���
� 
erob� o   + ,�� 0 fortext forText�  �  �  v ��� Z   4������ =  4 7��� o   4 5�� 0 newtext newText� m   5 6�
� 
msng� l  :���� k   :�� ��� Z   : ������ =  : =��� o   : ;�� 0 resultformat resultFormat� m   ; <� 
�  RetEMatT� r   @ S��� J   @ D�� ��� m   @ A��
�� boovfals� ���� m   A B��
�� boovtrue��  � J      �� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  � ��� =  V Y��� o   V W���� 0 resultformat resultFormat� m   W X��
�� RetEUmaT� ��� r   \ o��� J   \ `�� ��� m   \ ]��
�� boovtrue� ���� m   ] ^��
�� boovfals��  � J      �� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  � ��� =  r u��� o   r s���� 0 resultformat resultFormat� m   s t��
�� RetEAllT� ���� r   x ���� J   x |�� ��� m   x y��
�� boovtrue� ���� m   y z��
�� boovtrue��  � J      �� ��� o      ���� &0 includenonmatches includeNonMatches� ���� o      ����  0 includematches includeMatches��  ��  � n  � ���� I   � �������� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   � ����� 0 resultformat resultFormat� ���� m   � ��� ���  r e t u r n i n g��  ��  � o   � ����� 0 _supportlib _supportLib� ���� Z   ������ =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpI� P   � ����� L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ���
�� conswhit� ����
�� consnume��  � ����
�� conscase��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpP� ��� L   � ��� I   � �������� 0 _findpattern _findPattern� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ��� =  � ���� o   � ����� 0 matchformat matchFormat� m   � ���
�� SerECmpC� ��� P   � ������ L   � ��� I   � �������� 0 	_findtext 	_findText� ��� o   � ����� 0 thetext theText� ��� o   � ����� 0 fortext forText� ��� o   � ����� &0 includenonmatches includeNonMatches� ���� o   � �����  0 includematches includeMatches��  ��  � ���
�� conscase� ���
�� consdiac� �� 
�� conshyph  ��
�� conspunc ��
�� conswhit ����
�� consnume��  ��  �  =  � � o   � ����� 0 matchformat matchFormat m   � ���
�� SerECmpD �� L   � � I   � ���	���� 0 	_findtext 	_findText	 

 o   � ����� 0 thetext theText  o   � ����� 0 fortext forText  o   � ����� &0 includenonmatches includeNonMatches �� o   � �����  0 includematches includeMatches��  ��  ��  � n   I  ������ >0 throwinvalidparameterconstant throwInvalidParameterConstant  o  ���� 0 matchformat matchFormat �� m  	 � 
 u s i n g��  ��   o   ���� 0 _supportlib _supportLib��  �   find   � � 
   f i n d�  � l � k  �  r   !  n "#" I  ��$���� "0 astextparameter asTextParameter$ %&% o  ���� 0 newtext newText& '��' m  (( �))  r e p l a c i n g   w i t h��  ��  # o  ���� 0 _supportlib _supportLib! o      ���� 0 newtext newText *��* Z   �+,-.+ =  %/0/ o   !���� 0 matchformat matchFormat0 m  !$��
�� SerECmpI, P  (;1231 L  1:44 I  19��5���� 0 _replacetext _replaceText5 676 o  23���� 0 thetext theText7 898 o  34���� 0 fortext forText9 :��: o  45���� 0 newtext newText��  ��  2 ��;
�� consdiac; ��<
�� conshyph< ��=
�� conspunc= ��>
�� conswhit> ����
�� consnume��  3 ����
�� conscase��  - ?@? = >CABA o  >?���� 0 matchformat matchFormatB m  ?B��
�� SerECmpP@ CDC L  FOEE I  FN��F���� "0 _replacepattern _replacePatternF GHG o  GH���� 0 thetext theTextH IJI o  HI���� 0 fortext forTextJ K��K o  IJ���� 0 newtext newText��  ��  D LML = RWNON o  RS���� 0 matchformat matchFormatO m  SV��
�� SerECmpCM PQP P  ZkRS��R L  ajTT I  ai��U���� 0 _replacetext _replaceTextU VWV o  bc���� 0 thetext theTextW XYX o  cd���� 0 fortext forTextY Z��Z o  de���� 0 newtext newText��  ��  S ��[
�� conscase[ �\
� consdiac\ �~]
�~ conshyph] �}^
�} conspunc^ �|_
�| conswhit_ �{�z
�{ consnume�z  ��  Q `a` = nsbcb o  no�y�y 0 matchformat matchFormatc m  or�x
�x SerECmpDa d�wd L  vee I  v~�vf�u�v 0 _replacetext _replaceTextf ghg o  wx�t�t 0 thetext theTexth iji o  xy�s�s 0 fortext forTextj k�rk o  yz�q�q 0 newtext newText�r  �u  �w  . n ��lml I  ���pn�o�p >0 throwinvalidparameterconstant throwInvalidParameterConstantn opo o  ���n�n 0 matchformat matchFormatp q�mq m  ��rr �ss 
 u s i n g�m  �o  m o  ���l�l 0 _supportlib _supportLib��     replace    �tt    r e p l a c e�  V R      �kuv
�k .ascrerr ****      � ****u o      �j�j 0 etext eTextv �iwx
�i 
errnw o      �h�h 0 enumber eNumberx �gyz
�g 
eroby o      �f�f 0 efrom eFromz �e{�d
�e 
errt{ o      �c�c 
0 eto eTo�d  W I  ���b|�a�b 
0 _error  | }~} m  �� ���  s e a r c h   t e x t~ ��� o  ���`�` 0 etext eText� ��� o  ���_�_ 0 enumber eNumber� ��� o  ���^�^ 0 efrom eFrom� ��]� o  ���\�\ 
0 eto eTo�]  �a  ? ��� l     �[�Z�Y�[  �Z  �Y  � ��� l     �X�W�V�X  �W  �V  � ��� i  F I��� I     �U��T
�U .Txt:EPatnull���     ctxt� o      �S�S 0 thetext theText�T  � Q     *���� L    �� c    ��� l   ��R�Q� n   ��� I    �P��O�P 40 escapedpatternforstring_ escapedPatternForString_� ��N� l   ��M�L� n   ��� I    �K��J�K "0 astextparameter asTextParameter� ��� o    �I�I 0 thetext theText� ��H� m    �� ���  �H  �J  � o    �G�G 0 _supportlib _supportLib�M  �L  �N  �O  � n   ��� o    �F�F *0 nsregularexpression NSRegularExpression� m    �E
�E misccura�R  �Q  � m    �D
�D 
ctxt� R      �C��
�C .ascrerr ****      � ****� o      �B�B 0 etext eText� �A��
�A 
errn� o      �@�@ 0 enumber eNumber� �?��
�? 
erob� o      �>�> 0 efrom eFrom� �=��<
�= 
errt� o      �;�; 
0 eto eTo�<  � I     *�:��9�: 
0 _error  � ��� m   ! "�� ���  e s c a p e   p a t t e r n� ��� o   " #�8�8 0 etext eText� ��� o   # $�7�7 0 enumber eNumber� ��� o   $ %�6�6 0 efrom eFrom� ��5� o   % &�4�4 
0 eto eTo�5  �9  � ��� l     �3�2�1�3  �2  �1  � ��� l     �0�/�.�0  �/  �.  � ��� i  J M��� I     �-��,
�- .Txt:ETemnull���     ctxt� o      �+�+ 0 thetext theText�,  � Q     *���� L    �� c    ��� l   ��*�)� n   ��� I    �(��'�( 60 escapedtemplateforstring_ escapedTemplateForString_� ��&� l   ��%�$� n   ��� I    �#��"�# "0 astextparameter asTextParameter� ��� o    �!�! 0 thetext theText� �� � m    �� ���  �   �"  � o    �� 0 _supportlib _supportLib�%  �$  �&  �'  � n   ��� o    �� *0 nsregularexpression NSRegularExpression� m    �
� misccura�*  �)  � m    �
� 
ctxt� R      ���
� .ascrerr ****      � ****� o      �� 0 etext eText� ���
� 
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I     *���� 
0 _error  � ��� m   ! "�� ���  e s c a p e   t e m p l a t e� ��� o   " #�� 0 etext eText� ��� o   # $�� 0 enumber eNumber� ��� o   $ %�� 0 efrom eFrom� ��� o   % &�� 
0 eto eTo�  �  � ��� l     ��
�	�  �
  �	  � ��� l     ����  �  �  � ��� l     ����  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ����  �   Conversion Suite   � ��� "   C o n v e r s i o n   S u i t e� ��� l     ����  �  �  � ��� i  N Q��� I      �  ���  0 	_pinindex 	_pinIndex   o      ���� 0 theindex theIndex �� o      ���� 0 
textlength 
textLength��  ��  � l    % Z     %	
 ?      o     ���� 0 theindex theIndex o    ���� 0 
textlength 
textLength L     o    ���� 0 
textlength 
textLength	  A     o    ���� 0 theindex theIndex d     o    ���� 0 
textlength 
textLength  L     d     o    ���� 0 
textlength 
textLength  =     o    ���� 0 theindex theIndex m    ����   �� L      m    ���� ��  
 L   # % o   # $���� 0 theindex theIndex i c used by `slice text` to prevent 'out of range' errors (caution: textLength must be greater than 0)    � �   u s e d   b y   ` s l i c e   t e x t `   t o   p r e v e n t   ' o u t   o f   r a n g e '   e r r o r s   ( c a u t i o n :   t e x t L e n g t h   m u s t   b e   g r e a t e r   t h a n   0 )�   l     ��������  ��  ��    !"! l     ��������  ��  ��  " #$# l     ��%&��  %  -----   & �'' 
 - - - - -$ ()( l     ��������  ��  ��  ) *+* i  R U,-, I     ��./
�� .Txt:UppTnull���     ctxt. o      ���� 0 thetext theText/ ��0��
�� 
Loca0 |����1��2��  ��  1 o      ���� 0 
localecode 
localeCode��  2 l     3����3 m      ��
�� 
msng��  ��  ��  - Q     N4564 k    <77 898 r    :;: n   <=< I    ��>���� &0 stringwithstring_ stringWithString_> ?��? l   @����@ n   ABA I    ��C���� "0 astextparameter asTextParameterC DED o    ���� 0 thetext theTextE F��F m    GG �HH  ��  ��  B o    ���� 0 _supportlib _supportLib��  ��  ��  ��  = n   IJI o    ���� 0 nsstring NSStringJ m    ��
�� misccura; o      ���� 0 
asocstring 
asocString9 K��K Z    <LM��NL =   OPO o    ���� 0 
localecode 
localeCodeP m    ��
�� 
msngM L    &QQ c    %RSR l   #T����T n   #UVU I    #�������� "0 uppercasestring uppercaseString��  ��  V o    ���� 0 
asocstring 
asocString��  ��  S m   # $��
�� 
ctxt��  N L   ) <WW c   ) ;XYX l  ) 9Z����Z n  ) 9[\[ I   * 9��]���� 80 uppercasestringwithlocale_ uppercaseStringWithLocale_] ^��^ l  * 5_����_ n  * 5`a` I   / 5��b���� &0 aslocaleparameter asLocaleParameterb cdc o   / 0���� 0 
localecode 
localeCoded e��e m   0 1ff �gg  f o r   l o c a l e��  ��  a o   * /���� 0 _supportlib _supportLib��  ��  ��  ��  \ o   ) *���� 0 
asocstring 
asocString��  ��  Y m   9 :��
�� 
ctxt��  5 R      ��hi
�� .ascrerr ****      � ****h o      ���� 0 etext eTexti ��jk
�� 
errnj o      ���� 0 enumber eNumberk ��lm
�� 
erobl o      ���� 0 efrom eFromm ��n��
�� 
errtn o      ���� 
0 eto eTo��  6 I   D N��o���� 
0 _error  o pqp m   E Frr �ss  u p p e r c a s e   t e x tq tut o   F G���� 0 etext eTextu vwv o   G H���� 0 enumber eNumberw xyx o   H I���� 0 efrom eFromy z��z o   I J���� 
0 eto eTo��  ��  + {|{ l     ��������  ��  ��  | }~} l     ��������  ��  ��  ~ � i  V Y��� I     ����
�� .Txt:CapTnull���     ctxt� o      ���� 0 thetext theText� �����
�� 
Loca� |����������  ��  � o      ���� 0 
localecode 
localeCode��  � l     ������ m      ��
�� 
msng��  ��  ��  � Q     N���� k    <�� ��� r    ��� n   ��� I    ������� &0 stringwithstring_ stringWithString_� ���� l   ������ n   ��� I    ������� "0 astextparameter asTextParameter� ��� o    ���� 0 thetext theText� ���� m    �� ���  ��  ��  � o    ���� 0 _supportlib _supportLib��  ��  ��  ��  � n   ��� o    ���� 0 nsstring NSString� m    ��
�� misccura� o      ���� 0 
asocstring 
asocString� ���� Z    <������ =   ��� o    ���� 0 
localecode 
localeCode� m    ��
�� 
msng� L    &�� c    %��� l   #������ n   #��� I    #������� &0 capitalizedstring capitalizedString��  �  � o    �~�~ 0 
asocstring 
asocString��  ��  � m   # $�}
�} 
ctxt��  � L   ) <�� c   ) ;��� l  ) 9��|�{� n  ) 9��� I   * 9�z��y�z <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_� ��x� l  * 5��w�v� n  * 5��� I   / 5�u��t�u &0 aslocaleparameter asLocaleParameter� ��� o   / 0�s�s 0 
localecode 
localeCode� ��r� m   0 1�� ���  f o r   l o c a l e�r  �t  � o   * /�q�q 0 _supportlib _supportLib�w  �v  �x  �y  � o   ) *�p�p 0 
asocstring 
asocString�|  �{  � m   9 :�o
�o 
ctxt��  � R      �n��
�n .ascrerr ****      � ****� o      �m�m 0 etext eText� �l��
�l 
errn� o      �k�k 0 enumber eNumber� �j��
�j 
erob� o      �i�i 0 efrom eFrom� �h��g
�h 
errt� o      �f�f 
0 eto eTo�g  � I   D N�e��d�e 
0 _error  � ��� m   E F�� ���  c a p i t a l i z e   t e x t� ��� o   F G�c�c 0 etext eText� ��� o   G H�b�b 0 enumber eNumber� ��� o   H I�a�a 0 efrom eFrom� ��`� o   I J�_�_ 
0 eto eTo�`  �d  � ��� l     �^�]�\�^  �]  �\  � ��� l     �[�Z�Y�[  �Z  �Y  � ��� i  Z ]��� I     �X��
�X .Txt:LowTnull���     ctxt� o      �W�W 0 thetext theText� �V��U
�V 
Loca� |�T�S��R��T  �S  � o      �Q�Q 0 
localecode 
localeCode�R  � l     ��P�O� m      �N
�N 
msng�P  �O  �U  � Q     N���� k    <�� ��� r    ��� n   ��� I    �M��L�M &0 stringwithstring_ stringWithString_� ��K� l   ��J�I� n   ��� I    �H��G�H "0 astextparameter asTextParameter� ��� o    �F�F 0 thetext theText� ��E� m    �� ���  �E  �G  � o    �D�D 0 _supportlib _supportLib�J  �I  �K  �L  � n   ��� o    �C�C 0 nsstring NSString� m    �B
�B misccura� o      �A�A 0 
asocstring 
asocString� ��@� Z    <���?�� =   ��� o    �>�> 0 
localecode 
localeCode� m    �=
�= 
msng� L    &�� c    %��� l   #��<�;� n   #� � I    #�:�9�8�: "0 lowercasestring lowercaseString�9  �8    o    �7�7 0 
asocstring 
asocString�<  �;  � m   # $�6
�6 
ctxt�?  � L   ) < c   ) ; l  ) 9�5�4 n  ) 9 I   * 9�3�2�3 80 lowercasestringwithlocale_ lowercaseStringWithLocale_ �1 l  * 5	�0�/	 n  * 5

 I   / 5�.�-�. &0 aslocaleparameter asLocaleParameter  o   / 0�,�, 0 
localecode 
localeCode �+ m   0 1 �  f o r   l o c a l e�+  �-   o   * /�*�* 0 _supportlib _supportLib�0  �/  �1  �2   o   ) *�)�) 0 
asocstring 
asocString�5  �4   m   9 :�(
�( 
ctxt�@  � R      �'
�' .ascrerr ****      � **** o      �&�& 0 etext eText �%
�% 
errn o      �$�$ 0 enumber eNumber �#
�# 
erob o      �"�" 0 efrom eFrom �!� 
�! 
errt o      �� 
0 eto eTo�   � I   D N��� 
0 _error    m   E F �  l o w e r c a s e   t e x t  o   F G�� 0 etext eText  !  o   G H�� 0 enumber eNumber! "#" o   H I�� 0 efrom eFrom# $�$ o   I J�� 
0 eto eTo�  �  � %&% l     ����  �  �  & '(' l     ����  �  �  ( )*) i  ^ a+,+ I     �-.
� .Txt:PadTnull���     ctxt- o      �� 0 thetext theText. �/0
� 
toPl/ o      �� 0 toplaces toPlaces0 �12
� 
Char1 |��3�
4�  �  3 o      �	�	 0 padchar padChar�
  4 m      55 �66   2 �7�
� 
From7 |��8�9�  �  8 o      �� 0 whichend whichEnd�  9 l     :��: m      � 
�  LeTrLCha�  �  �  , k     �;; <=< l     ��>?��  > � � TO DO: what if pad is multi-char? how best to align on right? e.g. if pad is ". " then ideally the periods should always appear in same columns, e.g. "foo. . ." vs "food . ."   ? �@@^   T O   D O :   w h a t   i f   p a d   i s   m u l t i - c h a r ?   h o w   b e s t   t o   a l i g n   o n   r i g h t ?   e . g .   i f   p a d   i s   " .   "   t h e n   i d e a l l y   t h e   p e r i o d s   s h o u l d   a l w a y s   a p p e a r   i n   s a m e   c o l u m n s ,   e . g .   " f o o .   .   . "   v s   " f o o d   .   . "= A��A Q     �BCDB k    �EE FGF r    HIH n   JKJ I    ��L���� "0 astextparameter asTextParameterL MNM o    	���� 0 thetext theTextN O��O m   	 
PP �QQ  ��  ��  K o    ���� 0 _supportlib _supportLibI o      ���� 0 thetext theTextG RSR r    TUT n   VWV I    ��X���� (0 asintegerparameter asIntegerParameterX YZY o    ���� 0 toplaces toPlacesZ [��[ m    \\ �]]  t o   p l a c e s��  ��  W o    ���� 0 _supportlib _supportLibU o      ���� 0 toplaces toPlacesS ^_^ r    &`a` \    $bcb o     ���� 0 toplaces toPlacesc l    #d����d n    #efe 1   ! #��
�� 
lengf o     !���� 0 thetext theText��  ��  a o      ���� 0 	charcount 	charCount_ ghg Z  ' 3ij����i B   ' *klk o   ' (���� 0 	charcount 	charCountl m   ( )����  j L   - /mm o   - .���� 0 thetext theText��  ��  h non r   4 Apqp n  4 ?rsr I   9 ?��t���� "0 astextparameter asTextParametert uvu o   9 :���� 0 padchar padCharv w��w m   : ;xx �yy 
 u s i n g��  ��  s o   4 9���� 0 _supportlib _supportLibq o      ���� 0 padtext padTexto z{z Z  B V|}����| =   B G~~ n  B E��� 1   C E��
�� 
leng� o   B C���� 0 padtext padText m   E F����  } R   J R����
�� .ascrerr ****      � ****� m   P Q�� ��� f I n v a l i d    u s i n g    p a r a m e t e r   ( e m p t y   t e x t   n o t   a l l o w e d ) .� ����
�� 
errn� m   L M�����Y� �����
�� 
erob� o   N O���� 0 padchar padChar��  ��  ��  { ��� V   W k��� r   a f��� b   a d��� o   a b���� 0 padtext padText� o   b c���� 0 padtext padText� o      ���� 0 padtext padText� A   [ `��� n  [ ^��� 1   \ ^��
�� 
leng� o   [ \���� 0 padtext padText� o   ^ _���� 0 	charcount 	charCount� ���� Z   l ������ =  l o��� o   l m���� 0 whichend whichEnd� m   m n��
�� LeTrLCha� L   r ��� b   r ��� l  r }������ n  r }��� 7  s }����
�� 
ctxt� m   w y���� � o   z |���� 0 	charcount 	charCount� o   r s���� 0 padtext padText��  ��  � o   } ~���� 0 thetext theText� ��� =  � ���� o   � ����� 0 whichend whichEnd� m   � ���
�� LeTrTCha� ��� L   � ��� b   � ���� o   � ����� 0 thetext theText� l  � ������� n  � ���� 7  � �����
�� 
ctxt� m   � ����� � o   � ����� 0 	charcount 	charCount� o   � ����� 0 padtext padText��  ��  � ��� =  � ���� o   � ����� 0 whichend whichEnd� m   � ���
�� LeTrBCha� ���� Z   � ������� =   � ���� o   � ����� 0 	charcount 	charCount� m   � ����� � L   � ��� b   � ���� o   � ����� 0 thetext theText� l  � ������� n  � ���� 7  � �����
�� 
ctxt� m   � ����� � o   � ����� 0 	charcount 	charCount� o   � ����� 0 padtext padText��  ��  ��  � L   � ��� n  � ���� 7  � �����
�� 
ctxt� m   � ����� � o   � ����� 0 toplaces toPlaces� l  � ������� b   � ���� b   � ���� n  � ���� 7  � �����
�� 
ctxt� m   � ����� � l  � ������� _   � ���� o   � ����� 0 	charcount 	charCount� m   � ����� ��  ��  � o   � ����� 0 padtext padText� o   � ����� 0 thetext theText� o   � ����� 0 padtext padText��  ��  ��  � n  � ���� I   � �������� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   � ����� 0 whichend whichEnd� ���� m   � ��� ���  a d d i n g��  ��  � o   � ����� 0 _supportlib _supportLib��  C R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  D I   � �������� 
0 _error  � ��� m   � ��� ���  p a d   t e x t� ��� o   � ����� 0 etext eText� ��� o   � ����� 0 enumber eNumber� ��� o   � ����� 0 efrom eFrom� ���� o   � ����� 
0 eto eTo��  ��  ��  * ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  b e��� I     ����
�� .Txt:SliTnull���     ctxt� o      ���� 0 thetext theText� ����
�� 
Idx1� |����������  ��  � o      ���� 0 
startindex 
startIndex��  � m      �� � �~��}
�~ 
Idx2� |�|�{��z �|  �{  � o      �y�y 0 endindex endIndex�z    d       m      �x�x �}  � Q     k k    Y  r    	 n   

 I    �w�v�w "0 astextparameter asTextParameter  o    	�u�u 0 thetext theText �t m   	 
 �  �t  �v   o    �s�s 0 _supportlib _supportLib	 o      �r�r 0 thetext theText  l    Z   �q�p =     n    1    �o
�o 
leng o    �n�n 0 thetext theText m    �m�m   L     m     �  �q  �p  
 caution: testing for `theText is ""` is dependent on current considering/ignoring settings, thus, the only safe ways to check for an empty/non-empty string are to 1. count its characters, or 2. wrap it in a `considering hyphens, punctuation, and white space` block     �     c a u t i o n :   t e s t i n g   f o r   ` t h e T e x t   i s   " " `   i s   d e p e n d e n t   o n   c u r r e n t   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s ,   t h u s ,   t h e   o n l y   s a f e   w a y s   t o   c h e c k   f o r   a n   e m p t y / n o n - e m p t y   s t r i n g   a r e   t o   1 .   c o u n t   i t s   c h a r a c t e r s ,   o r   2 .   w r a p   i t   i n   a   ` c o n s i d e r i n g   h y p h e n s ,   p u n c t u a t i o n ,   a n d   w h i t e   s p a c e `   b l o c k   !"! l     �l�k�j�l  �k  �j  " #$# l     �i%&�i  % � � TO DO: what if startindex comes after endindex? swap them and return text range as normal, or return empty text? (could even return the specified text range with the characters reversed, but I suspect that won't be helpful)   & �''�   T O   D O :   w h a t   i f   s t a r t i n d e x   c o m e s   a f t e r   e n d i n d e x ?   s w a p   t h e m   a n d   r e t u r n   t e x t   r a n g e   a s   n o r m a l ,   o r   r e t u r n   e m p t y   t e x t ?   ( c o u l d   e v e n   r e t u r n   t h e   s p e c i f i e d   t e x t   r a n g e   w i t h   t h e   c h a r a c t e r s   r e v e r s e d ,   b u t   I   s u s p e c t   t h a t   w o n ' t   b e   h e l p f u l )$ ()( l     �h�g�f�h  �g  �f  ) *+* l     �e,-�e  , � � TO DO: if the entire slice is out of range (i.e. *both* indexes are before or after the first/last character) then need to return "" (currently, because of how it pins, it'll return a single character instead, which is incorrect)   - �..�   T O   D O :   i f   t h e   e n t i r e   s l i c e   i s   o u t   o f   r a n g e   ( i . e .   * b o t h *   i n d e x e s   a r e   b e f o r e   o r   a f t e r   t h e   f i r s t / l a s t   c h a r a c t e r )   t h e n   n e e d   t o   r e t u r n   " "   ( c u r r e n t l y ,   b e c a u s e   o f   h o w   i t   p i n s ,   i t ' l l   r e t u r n   a   s i n g l e   c h a r a c t e r   i n s t e a d ,   w h i c h   i s   i n c o r r e c t )+ /0/ r     5121 I     3�d3�c�d 0 	_pinindex 	_pinIndex3 454 n  ! ,676 I   & ,�b8�a�b (0 asintegerparameter asIntegerParameter8 9:9 o   & '�`�` 0 
startindex 
startIndex: ;�_; m   ' (<< �==  f r o m�_  �a  7 o   ! &�^�^ 0 _supportlib _supportLib5 >�]> n   , /?@? 1   - /�\
�\ 
leng@ o   , -�[�[ 0 thetext theText�]  �c  2 o      �Z�Z 0 
startindex 
startIndex0 ABA r   6 KCDC I   6 I�YE�X�Y 0 	_pinindex 	_pinIndexE FGF n  7 BHIH I   < B�WJ�V�W (0 asintegerparameter asIntegerParameterJ KLK o   < =�U�U 0 endindex endIndexL M�TM m   = >NN �OO  t o�T  �V  I o   7 <�S�S 0 _supportlib _supportLibG P�RP n   B EQRQ 1   C E�Q
�Q 
lengR o   B C�P�P 0 thetext theText�R  �X  D o      �O�O 0 endindex endIndexB S�NS L   L YTT n   L XUVU 7  M W�MWX
�M 
ctxtW o   Q S�L�L 0 
startindex 
startIndexX o   T V�K�K 0 endindex endIndexV o   L M�J�J 0 thetext theText�N   R      �IYZ
�I .ascrerr ****      � ****Y o      �H�H 0 etext eTextZ �G[\
�G 
errn[ o      �F�F 0 enumber eNumber\ �E]^
�E 
erob] o      �D�D 0 efrom eFrom^ �C_�B
�C 
errt_ o      �A�A 
0 eto eTo�B   I   a k�@`�?�@ 
0 _error  ` aba m   b ccc �dd  s l i c e   t e x tb efe o   c d�>�> 0 etext eTextf ghg o   d e�=�= 0 enumber eNumberh iji o   e f�<�< 0 efrom eFromj k�;k o   f g�:�: 
0 eto eTo�;  �?  � lml l     �9�8�7�9  �8  �7  m non l     �6�5�4�6  �5  �4  o pqp i  f irsr I     �3tu
�3 .Txt:TrmTnull���     ctxtt o      �2�2 0 thetext theTextu �1v�0
�1 
Fromv |�/�.w�-x�/  �.  w o      �,�, 0 whichend whichEnd�-  x l     y�+�*y m      �)
�) LeTrBCha�+  �*  �0  s Q     �z{|z k    �}} ~~ r    ��� n   ��� I    �(��'�( "0 astextparameter asTextParameter� ��� o    	�&�& 0 thetext theText� ��%� m   	 
�� ���  �%  �'  � o    �$�$ 0 _supportlib _supportLib� o      �#�# 0 thetext theText ��� Z    -���"�!� H    �� E   ��� J    �� ��� m    � 
�  LeTrLCha� ��� m    �
� LeTrTCha� ��� m    �
� LeTrBCha�  � J    �� ��� o    �� 0 whichend whichEnd�  � n   )��� I   # )���� >0 throwinvalidparameterconstant throwInvalidParameterConstant� ��� o   # $�� 0 whichend whichEnd� ��� m   $ %�� ���  r e m o v i n g�  �  � o    #�� 0 _supportlib _supportLib�"  �!  � ��� P   . ����� k   3 ��� ��� l  3 ?���� Z  3 ?����� =  3 6��� o   3 4�� 0 thetext theText� m   4 5�� ���  � L   9 ;�� m   9 :�� ���  �  �  � H B check if theText is empty or contains white space characters only   � ��� �   c h e c k   i f   t h e T e x t   i s   e m p t y   o r   c o n t a i n s   w h i t e   s p a c e   c h a r a c t e r s   o n l y� ��� r   @ S��� J   @ D�� ��� m   @ A�� � ��� m   A B�����  � J      �� ��� o      �� 0 
startindex 
startIndex� ��� o      �� 0 endindex endIndex�  � ��� Z   T x����
� E  T \��� J   T X�� ��� m   T U�	
�	 LeTrLCha� ��� m   U V�
� LeTrBCha�  � J   X [�� ��� o   X Y�� 0 whichend whichEnd�  � V   _ t��� r   j o��� [   j m��� o   j k�� 0 
startindex 
startIndex� m   k l�� � o      �� 0 
startindex 
startIndex� =  c i��� n   c g��� 4   d g��
� 
cha � o   e f� �  0 
startindex 
startIndex� o   c d���� 0 thetext theText� m   g h�� ���  �  �
  � ��� Z   y �������� E  y ���� J   y }�� ��� m   y z��
�� LeTrTCha� ���� m   z {��
�� LeTrBCha��  � J   } ��� ���� o   } ~���� 0 whichend whichEnd��  � V   � ���� r   � ���� \   � ���� o   � ����� 0 endindex endIndex� m   � ����� � o      ���� 0 endindex endIndex� =  � ���� n   � ���� 4   � ����
�� 
cha � o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText� m   � ��� ���  ��  ��  � ���� L   � ��� n   � ���� 7  � �����
�� 
ctxt� o   � ����� 0 
startindex 
startIndex� o   � ����� 0 endindex endIndex� o   � ����� 0 thetext theText��  � ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ����
�� conspunc��  � ���
�� consnume� ����
�� conswhit��  �  { R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ���	 
�� 
errn� o      ���� 0 enumber eNumber	  ��		
�� 
erob	 o      ���� 0 efrom eFrom	 ��	��
�� 
errt	 o      ���� 
0 eto eTo��  | I   � ���	���� 
0 _error  	 			 m   � �		 �		  t r i m   t e x t	 			
		 o   � ����� 0 etext eText	
 			 o   � ����� 0 enumber eNumber	 			 o   � ����� 0 efrom eFrom	 	��	 o   � ����� 
0 eto eTo��  ��  q 			 l     ��������  ��  ��  	 			 l     ��������  ��  ��  	 			 l     ��		��  	 J D--------------------------------------------------------------------   	 �		 � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -	 			 l     ��		��  	   Split and Join Suite   	 �		 *   S p l i t   a n d   J o i n   S u i t e	 			 l     ��������  ��  ��  	 	 	!	  i  j m	"	#	" I      ��	$���� 0 
_splittext 
_splitText	$ 	%	&	% o      ���� 0 thetext theText	& 	'��	' o      ���� 0 theseparator theSeparator��  ��  	# l    ^	(	)	*	( k     ^	+	+ 	,	-	, r     	.	/	. n    
	0	1	0 I    
��	2���� "0 aslistparameter asListParameter	2 	3��	3 o    ���� 0 theseparator theSeparator��  ��  	1 o     ���� 0 _supportlib _supportLib	/ o      ���� 0 delimiterlist delimiterList	- 	4	5	4 X    C	6��	7	6 Q    >	8	9	:	8 l    )	;	<	=	; r     )	>	?	> c     %	@	A	@ n     #	B	C	B 1   ! #��
�� 
pcnt	C o     !���� 0 aref aRef	A m   # $��
�� 
ctxt	? n      	D	E	D 1   & (��
�� 
pcnt	E o   % &���� 0 aref aRef	<�� caution: AS silently ignores invalid TID values, so separator items must be explicitly validated to catch any user errors; for now, just coerce to text and catch errors, but might want to make it more rigorous in future (e.g. if a list of lists is given, should sublist be treated as an error instead of just coercing it to text, which is itself TIDs sensitive); see also existing TODO on LibrarySupportLib's asTextParameter handler   	= �	F	Fb   c a u t i o n :   A S   s i l e n t l y   i g n o r e s   i n v a l i d   T I D   v a l u e s ,   s o   s e p a r a t o r   i t e m s   m u s t   b e   e x p l i c i t l y   v a l i d a t e d   t o   c a t c h   a n y   u s e r   e r r o r s ;   f o r   n o w ,   j u s t   c o e r c e   t o   t e x t   a n d   c a t c h   e r r o r s ,   b u t   m i g h t   w a n t   t o   m a k e   i t   m o r e   r i g o r o u s   i n   f u t u r e   ( e . g .   i f   a   l i s t   o f   l i s t s   i s   g i v e n ,   s h o u l d   s u b l i s t   b e   t r e a t e d   a s   a n   e r r o r   i n s t e a d   o f   j u s t   c o e r c i n g   i t   t o   t e x t ,   w h i c h   i s   i t s e l f   T I D s   s e n s i t i v e ) ;   s e e   a l s o   e x i s t i n g   T O D O   o n   L i b r a r y S u p p o r t L i b ' s   a s T e x t P a r a m e t e r   h a n d l e r	9 R      ����	G
�� .ascrerr ****      � ****��  	G ��	H��
�� 
errn	H d      	I	I m      �������  	: l  1 >	J	K	L	J n  1 >	M	N	M I   6 >��	O���� 60 throwinvalidparametertype throwInvalidParameterType	O 	P	Q	P o   6 7���� 0 theseparator theSeparator	Q 	R	S	R m   7 8	T	T �	U	U  u s i n g   s e p a r a t o r	S 	V	W	V m   8 9	X	X �	Y	Y  l i s t   o f   t e x t	W 	Z��	Z m   9 :��
�� 
list��  ��  	N o   1 6���� 0 _supportlib _supportLib	K � TO DO: would it be better to return a reference to the invalid item rather than the entire list? note that ListLib uses `a ref to item INDEX of LIST` for `eFrom`, which makes the problem value obvious (also, what to use for `eTo` as `list` is vague?)   	L �	[	[�   T O   D O :   w o u l d   i t   b e   b e t t e r   t o   r e t u r n   a   r e f e r e n c e   t o   t h e   i n v a l i d   i t e m   r a t h e r   t h a n   t h e   e n t i r e   l i s t ?   n o t e   t h a t   L i s t L i b   u s e s   ` a   r e f   t o   i t e m   I N D E X   o f   L I S T `   f o r   ` e F r o m ` ,   w h i c h   m a k e s   t h e   p r o b l e m   v a l u e   o b v i o u s   ( a l s o ,   w h a t   t o   u s e   f o r   ` e T o `   a s   ` l i s t `   i s   v a g u e ? )�� 0 aref aRef	7 o    ���� 0 delimiterlist delimiterList	5 	\	]	\ r   D I	^	_	^ n  D G	`	a	` 1   E G��
�� 
txdl	a 1   D E��
�� 
ascr	_ o      ���� 0 oldtids oldTIDs	] 	b	c	b r   J O	d	e	d o   J K���� 0 delimiterlist delimiterList	e n     	f	g	f 1   L N��
�� 
txdl	g 1   K L��
�� 
ascr	c 	h	i	h r   P U	j	k	j n   P S	l	m	l 2  Q S��
�� 
citm	m o   P Q���� 0 thetext theText	k o      ���� 0 
resultlist 
resultList	i 	n	o	n r   V [	p	q	p o   V W���� 0 oldtids oldTIDs	q n     	r	s	r 1   X Z��
�� 
txdl	s 1   W X��
�� 
ascr	o 	t��	t L   \ ^	u	u o   \ ]���� 0 
resultlist 
resultList��  	) � � used by `split text` to split text using one or more text item delimiters and current or predefined considering/ignoring settings   	* �	v	v   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   o n e   o r   m o r e   t e x t   i t e m   d e l i m i t e r s   a n d   c u r r e n t   o r   p r e d e f i n e d   c o n s i d e r i n g / i g n o r i n g   s e t t i n g s	! 	w	x	w l     ��������  ��  ��  	x 	y	z	y l     ��������  ��  ��  	z 	{	|	{ i  n q	}	~	} I      ��	���� 0 _splitpattern _splitPattern	 	�	�	� o      ���� 0 thetext theText	� 	���	� o      ���� 0 patterntext patternText��  ��  	~ l    �	�	�	�	� k     �	�	� 	�	�	� r     	�	�	� I     ��	����� 60 _compileregularexpression _compileRegularExpression	� 	���	� o    ���� 0 patterntext patternText��  ��  	� o      ���� 
0 regexp  	� 	�	�	� r   	 	�	�	� n  	 	�	�	� I    ��	����� &0 stringwithstring_ stringWithString_	� 	���	� o    ���� 0 thetext theText��  ��  	� n  	 	�	�	� o   
 ���� 0 nsstring NSString	� m   	 
��
�� misccura	� o      ���� 0 
asocstring 
asocString	� 	�	�	� l   	�	�	�	� r    	�	�	� m    ����  	� o      ���� &0 asocnonmatchstart asocNonMatchStart	� G A used to calculate NSRanges for non-matching portions of NSString   	� �	�	� �   u s e d   t o   c a l c u l a t e   N S R a n g e s   f o r   n o n - m a t c h i n g   p o r t i o n s   o f   N S S t r i n g	� 	�	�	� r    	�	�	� J    ����  	� o      ���� 0 
resultlist 
resultList	� 	�	�	� l   ��	�	���  	� @ : iterate over each non-matched + matched range in NSString   	� �	�	� t   i t e r a t e   o v e r   e a c h   n o n - m a t c h e d   +   m a t c h e d   r a n g e   i n   N S S t r i n g	� 	�	�	� r    .	�	�	� n   ,	�	�	� I    ,��	����� @0 matchesinstring_options_range_ matchesInString_options_range_	� 	�	�	� o    ���� 0 
asocstring 
asocString	� 	�	�	� m     ��  	� 	��~	� J     (	�	� 	�	�	� m     !�}�}  	� 	��|	� n  ! &	�	�	� I   " &�{�z�y�{ 
0 length  �z  �y  	� o   ! "�x�x 0 
asocstring 
asocString�|  �~  ��  	� o    �w�w 
0 regexp  	� o      �v�v  0 asocmatcharray asocMatchArray	� 	�	�	� Y   / v	��u	�	��t	� k   ? q	�	� 	�	�	� r   ? L	�	�	� l  ? J	��s�r	� n  ? J	�	�	� I   E J�q	��p�q 0 rangeatindex_ rangeAtIndex_	� 	��o	� m   E F�n�n  �o  �p  	� l  ? E	��m�l	� n  ? E	�	�	� I   @ E�k	��j�k  0 objectatindex_ objectAtIndex_	� 	��i	� o   @ A�h�h 0 i  �i  �j  	� o   ? @�g�g  0 asocmatcharray asocMatchArray�m  �l  �s  �r  	� o      �f�f  0 asocmatchrange asocMatchRange	� 	�	�	� r   M T	�	�	� n  M R	�	�	� I   N R�e�d�c�e 0 location  �d  �c  	� o   M N�b�b  0 asocmatchrange asocMatchRange	� o      �a�a  0 asocmatchstart asocMatchStart	� 	�	�	� r   U g	�	�	� c   U d	�	�	� l  U b	��`�_	� n  U b	�	�	� I   V b�^	��]�^ *0 substringwithrange_ substringWithRange_	� 	��\	� K   V ^	�	� �[	�	��[ 0 location  	� o   W X�Z�Z &0 asocnonmatchstart asocNonMatchStart	� �Y	��X�Y 
0 length  	� \   Y \	�	�	� o   Y Z�W�W  0 asocmatchstart asocMatchStart	� o   Z [�V�V &0 asocnonmatchstart asocNonMatchStart�X  �\  �]  	� o   U V�U�U 0 
asocstring 
asocString�`  �_  	� m   b c�T
�T 
ctxt	� n      	�	�	�  ;   e f	� o   d e�S�S 0 
resultlist 
resultList	� 	��R	� r   h q	�	�	� [   h o	�	�	� o   h i�Q�Q  0 asocmatchstart asocMatchStart	� l  i n	��P�O	� n  i n	�	�	� I   j n�N�M�L�N 
0 length  �M  �L  	� o   i j�K�K  0 asocmatchrange asocMatchRange�P  �O  	� o      �J�J &0 asocnonmatchstart asocNonMatchStart�R  �u 0 i  	� m   2 3�I�I  	� \   3 :	�	�	� l  3 8	��H�G	� n  3 8	�	�	� I   4 8�F�E�D�F 	0 count  �E  �D  	� o   3 4�C�C  0 asocmatcharray asocMatchArray�H  �G  	� m   8 9�B�B �t  	� 	�	�	� l  w w�A	�	��A  	� "  add final non-matched range   	� �	�	� 8   a d d   f i n a l   n o n - m a t c h e d   r a n g e	� 	�	�	� r   w �	�	�	� c   w 	�	�	� l  w }	��@�?	� n  w }
 

  I   x }�>
�=�> *0 substringfromindex_ substringFromIndex_
 
�<
 o   x y�;�; &0 asocnonmatchstart asocNonMatchStart�<  �=  
 o   w x�:�: 0 
asocstring 
asocString�@  �?  	� m   } ~�9
�9 
ctxt	� n      


  ;   � �
 o    ��8�8 0 
resultlist 
resultList	� 
�7
 L   � �

 o   � ��6�6 0 
resultlist 
resultList�7  	� Q K used by `split text` to split text using a regular expression as separator   	� �

 �   u s e d   b y   ` s p l i t   t e x t `   t o   s p l i t   t e x t   u s i n g   a   r e g u l a r   e x p r e s s i o n   a s   s e p a r a t o r	| 
	


	 l     �5�4�3�5  �4  �3  

 


 l     �2�1�0�2  �1  �0  
 


 i  r u


 I      �/
�.�/ 0 	_jointext 	_joinText
 


 o      �-�- 0 thelist theList
 
�,
 o      �+�+ 0 separatortext separatorText�,  �.  
 k     >

 


 r     


 n    


 1    �*
�* 
txdl
 1     �)
�) 
ascr
 o      �(�( 0 oldtids oldTIDs
 


 r    


 o    �'�' 0 delimiterlist delimiterList
 n     
 
!
  1    
�&
�& 
txdl
! 1    �%
�% 
ascr
 
"
#
" Q    5
$
%
&
$ r    
'
(
' c    
)
*
) n   
+
,
+ I    �$
-�#�$ "0 aslistparameter asListParameter
- 
.�"
. o    �!�! 0 thelist theList�"  �#  
, o    � �  0 _supportlib _supportLib
* m    �
� 
ctxt
( o      �� 0 
resulttext 
resultText
% R      ��
/
� .ascrerr ****      � ****�  
/ �
0�
� 
errn
0 d      
1
1 m      ����  
& k   % 5
2
2 
3
4
3 r   % *
5
6
5 o   % &�� 0 oldtids oldTIDs
6 n     
7
8
7 1   ' )�
� 
txdl
8 1   & '�
� 
ascr
4 
9�
9 R   + 5�
:
;
� .ascrerr ****      � ****
: m   3 4
<
< �
=
= b I n v a l i d   d i r e c t   p a r a m e t e r   ( e x p e c t e d   l i s t   o f   t e x t ) .
; �
>
?
� 
errn
> m   - .���Y
? �
@
A
� 
erob
@ o   / 0�� 0 thelist theList
A �
B�
� 
errt
B m   1 2�
� 
list�  �  
# 
C
D
C r   6 ;
E
F
E o   6 7�� 0 oldtids oldTIDs
F n     
G
H
G 1   8 :�
� 
txdl
H 1   7 8�

�
 
ascr
D 
I�	
I L   < >
J
J o   < =�� 0 
resulttext 
resultText�	  
 
K
L
K l     ����  �  �  
L 
M
N
M l     ����  �  �  
N 
O
P
O l     �
Q
R�  
Q  -----   
R �
S
S 
 - - - - -
P 
T
U
T l     � �����   ��  ��  
U 
V
W
V i  v y
X
Y
X I     ��
Z
[
�� .Txt:SplTnull���     ctxt
Z o      ���� 0 thetext theText
[ ��
\
]
�� 
Sepa
\ |����
^��
_��  ��  
^ o      ���� 0 theseparator theSeparator��  
_ l     
`����
` m      ��
�� 
msng��  ��  
] ��
a��
�� 
Usin
a |����
b��
c��  ��  
b o      ���� 0 matchformat matchFormat��  
c l     
d����
d m      ��
�� SerECmpI��  ��  ��  
Y k     �
e
e 
f
g
f l     ��
h
i��  
hrl convenience handler for splitting text using TIDs that can also use a regular expression pattern as separator; note that this is similar to using `search text theText for theSeparator returning non matching text` (except that `search text` returns start and end indexes as well as text), but avoids some of the overhead and is an obvious complement to `join text`   
i �
j
j�   c o n v e n i e n c e   h a n d l e r   f o r   s p l i t t i n g   t e x t   u s i n g   T I D s   t h a t   c a n   a l s o   u s e   a   r e g u l a r   e x p r e s s i o n   p a t t e r n   a s   s e p a r a t o r ;   n o t e   t h a t   t h i s   i s   s i m i l a r   t o   u s i n g   ` s e a r c h   t e x t   t h e T e x t   f o r   t h e S e p a r a t o r   r e t u r n i n g   n o n   m a t c h i n g   t e x t `   ( e x c e p t   t h a t   ` s e a r c h   t e x t `   r e t u r n s   s t a r t   a n d   e n d   i n d e x e s   a s   w e l l   a s   t e x t ) ,   b u t   a v o i d s   s o m e   o f   t h e   o v e r h e a d   a n d   i s   a n   o b v i o u s   c o m p l e m e n t   t o   ` j o i n   t e x t `
g 
k��
k Q     �
l
m
n
l k    �
o
o 
p
q
p r    
r
s
r n   
t
u
t I    ��
v���� "0 astextparameter asTextParameter
v 
w
x
w o    	���� 0 thetext theText
x 
y��
y m   	 

z
z �
{
{  ��  ��  
u o    ���� 0 _supportlib _supportLib
s o      ���� 0 thetext theText
q 
|��
| Z    �
}
~

�
} =   
�
�
� o    ���� 0 theseparator theSeparator
� m    ��
�� 
msng
~ l   
�
�
�
� L    
�
� I    ��
����� 0 _splitpattern _splitPattern
� 
�
�
� o    ���� 0 thetext theText
� 
���
� m    
�
� �
�
�  \ s +��  ��  
� g a if `at` parameter is omitted, splits on whitespace runs by default, ignoring any `using` options   
� �
�
� �   i f   ` a t `   p a r a m e t e r   i s   o m i t t e d ,   s p l i t s   o n   w h i t e s p a c e   r u n s   b y   d e f a u l t ,   i g n o r i n g   a n y   ` u s i n g `   o p t i o n s
 
�
�
� =  " %
�
�
� o   " #���� 0 matchformat matchFormat
� m   # $��
�� SerECmpI
� 
�
�
� P   ( 6
�
�
�
� L   - 5
�
� I   - 4��
����� 0 
_splittext 
_splitText
� 
�
�
� o   . /���� 0 thetext theText
� 
���
� o   / 0���� 0 theseparator theSeparator��  ��  
� ��
�
�� consdiac
� ��
�
�� conshyph
� ��
�
�� conspunc
� ��
�
�� conswhit
� ����
�� consnume��  
� ����
�� conscase��  
� 
�
�
� =  9 <
�
�
� o   9 :���� 0 matchformat matchFormat
� m   : ;��
�� SerECmpP
� 
�
�
� L   ? Q
�
� I   ? P��
����� 0 _splitpattern _splitPattern
� 
�
�
� o   @ A���� 0 thetext theText
� 
���
� n  A L
�
�
� I   F L��
����� "0 astextparameter asTextParameter
� 
�
�
� o   F G���� 0 theseparator theSeparator
� 
���
� m   G H
�
� �
�
�  a t��  ��  
� o   A F���� 0 _supportlib _supportLib��  ��  
� 
�
�
� =  T W
�
�
� o   T U���� 0 matchformat matchFormat
� m   U V��
�� SerECmpC
� 
�
�
� P   Z h
�
���
� L   _ g
�
� I   _ f��
����� 0 
_splittext 
_splitText
� 
�
�
� o   ` a���� 0 thetext theText
� 
���
� o   a b���� 0 theseparator theSeparator��  ��  
� ��
�
�� conscase
� ��
�
�� consdiac
� ��
�
�� conshyph
� ��
�
�� conspunc
� ��
�
�� conswhit
� ����
�� consnume��  ��  
� 
�
�
� =  k n
�
�
� o   k l���� 0 matchformat matchFormat
� m   l m��
�� SerECmpD
� 
���
� L   q y
�
� I   q x��
����� 0 
_splittext 
_splitText
� 
�
�
� o   r s���� 0 thetext theText
� 
���
� o   s t���� 0 theseparator theSeparator��  ��  ��  
� n  | �
�
�
� I   � ���
����� >0 throwinvalidparameterconstant throwInvalidParameterConstant
� 
�
�
� o   � ����� 0 matchformat matchFormat
� 
���
� m   � �
�
� �
�
� 
 u s i n g��  ��  
� o   | ����� 0 _supportlib _supportLib��  
m R      ��
�
�
�� .ascrerr ****      � ****
� o      ���� 0 etext eText
� ��
�
�
�� 
errn
� o      ���� 0 enumber eNumber
� ��
�
�
�� 
erob
� o      ���� 0 efrom eFrom
� ��
���
�� 
errt
� o      ���� 
0 eto eTo��  
n I   � ���
����� 
0 _error  
� 
�
�
� m   � �
�
� �
�
�  s p l i t   t e x t
� 
�
�
� o   � ����� 0 etext eText
� 
�
�
� o   � ����� 0 enumber eNumber
� 
�
�
� o   � ����� 0 efrom eFrom
� 
���
� o   � ����� 
0 eto eTo��  ��  ��  
W 
�
�
� l     ��������  ��  ��  
� 
�
�
� l     ��������  ��  ��  
� 
�
�
� i  z }
�
�
� I     ��
�
�
�� .Txt:JoiTnull���     ****
� o      ���� 0 thelist theList
� ��
���
�� 
Sepa
� |����
���
���  ��  
� o      ���� 0 separatortext separatorText��  
� m      
�
� �
�
�  ��  
� Q     '
�
�
�
� L    
�
� I    ��
����� 0 	_jointext 	_joinText
� 
�
�
� o    ���� 0 thelist theList
�  ��  n    I   
 ������ "0 astextparameter asTextParameter  o   
 ���� 0 separatortext separatorText �� m     �  u s i n g   s e p a r a t o r��  ��   o    
�� 0 _supportlib _supportLib��  ��  
� R      �~	

�~ .ascrerr ****      � ****	 o      �}�} 0 etext eText
 �|
�| 
errn o      �{�{ 0 enumber eNumber �z
�z 
erob o      �y�y 0 efrom eFrom �x�w
�x 
errt o      �v�v 
0 eto eTo�w  
� I    '�u�t�u 
0 _error    m     �  j o i n   t e x t  o     �s�s 0 etext eText  o     !�r�r 0 enumber eNumber  o   ! "�q�q 0 efrom eFrom �p o   " #�o�o 
0 eto eTo�p  �t  
�  l     �n�m�l�n  �m  �l    l     �k�j�i�k  �j  �i    !  i  ~ �"#" I     �h$�g
�h .Txt:SplPnull���     ctxt$ o      �f�f 0 thetext theText�g  # Q     $%&'% L    (( n    )*) 2   �e
�e 
cpar* n   +,+ I    �d-�c�d "0 astextparameter asTextParameter- ./. o    	�b�b 0 thetext theText/ 0�a0 m   	 
11 �22  �a  �c  , o    �`�` 0 _supportlib _supportLib& R      �_34
�_ .ascrerr ****      � ****3 o      �^�^ 0 etext eText4 �]56
�] 
errn5 o      �\�\ 0 enumber eNumber6 �[78
�[ 
erob7 o      �Z�Z 0 efrom eFrom8 �Y9�X
�Y 
errt9 o      �W�W 
0 eto eTo�X  ' I    $�V:�U�V 
0 _error  : ;<; m    == �>>   s p l i t   p a r a g r a p h s< ?@? o    �T�T 0 etext eText@ ABA o    �S�S 0 enumber eNumberB CDC o    �R�R 0 efrom eFromD E�QE o     �P�P 
0 eto eTo�Q  �U  ! FGF l     �O�N�M�O  �N  �M  G HIH l     �L�K�J�L  �K  �J  I JKJ i  � �LML I     �INO
�I .Txt:JoiPnull���     ****N o      �H�H 0 thelist theListO �GP�F
�G 
LiBrP |�E�DQ�CR�E  �D  Q o      �B�B 0 linebreaktype lineBreakType�C  R l     S�A�@S m      �?
�? LiBrLiOX�A  �@  �F  M Q     OTUVT k    =WW XYX Z    4Z[\]Z =   ^_^ o    �>�> 0 linebreaktype lineBreakType_ m    �=
�= LiBrLiOX[ r   	 `a` 1   	 
�<
�< 
lnfda o      �;�; 0 separatortext separatorText\ bcb =   ded o    �:�: 0 linebreaktype lineBreakTypee m    �9
�9 LiBrLiCMc fgf r    hih o    �8
�8 
ret i o      �7�7 0 separatortext separatorTextg jkj =   lml o    �6�6 0 linebreaktype lineBreakTypem m    �5
�5 LiBrLiWik n�4n r   ! &opo b   ! $qrq o   ! "�3
�3 
ret r 1   " #�2
�2 
lnfdp o      �1�1 0 separatortext separatorText�4  ] n  ) 4sts I   . 4�0u�/�0 >0 throwinvalidparameterconstant throwInvalidParameterConstantu vwv o   . /�.�. 0 linebreaktype lineBreakTypew x�-x m   / 0yy �zz 
 u s i n g�-  �/  t o   ) .�,�, 0 _supportlib _supportLibY {�+{ L   5 =|| I   5 <�*}�)�* 0 	_jointext 	_joinText} ~~ o   6 7�(�( 0 thelist theList ��'� o   7 8�&�& 0 separatortext separatorText�'  �)  �+  U R      �%��
�% .ascrerr ****      � ****� o      �$�$ 0 etext eText� �#��
�# 
errn� o      �"�" 0 enumber eNumber� �!��
�! 
erob� o      � �  0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  V I   E O���� 
0 _error  � ��� m   F G�� ���  j o i n   p a r a g r a p h s� ��� o   G H�� 0 etext eText� ��� o   H I�� 0 enumber eNumber� ��� o   I J�� 0 efrom eFrom� ��� o   J K�� 
0 eto eTo�  �  K ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ����  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ����  �   formatting   � ���    f o r m a t t i n g� ��� l     �
�	��
  �	  �  � ��� i  � ���� I      ���� (0 _makevalueiterator _makeValueIterator� ��� o      �� 0 
objectlist 
objectList�  �  � h     ��� 0 scpt  � k      �� ��� j     ��� 0 _objects  � c     ��� o     �� 0 
objectlist 
objectList� m    � 
�  
list� ��� j   	 ����� 0 i  � m   	 
����  � ���� i    ��� I     ������
�� .aevtoappnull  �   � ****��  ��  � k     7�� ��� r     ��� [     ��� o     ���� 0 i  � m    ���� � o      ���� 0 i  � ��� l   (���� Z   (������� ?    ��� o    ���� 0 i  � n    ��� 1    ��
�� 
leng� o    ���� 0 _objects  � R    $�����
�� .ascrerr ****      � ****��  � �����
�� 
errn� m     !�������  ��  ��  �   stop iteration   � ���    s t o p   i t e r a t i o n� ���� L   ) 7�� n   ) 6��� 4   . 5���
�� 
cobj� o   / 4���� 0 i  � o   ) .���� 0 _objects  ��  ��  � ��� l     ��������  ��  ��  � ��� l     ������  �  -----   � ��� 
 - - - - -� ��� l     ��������  ��  ��  � ��� i  � ���� I     �����
�� .Txt:FLitnull��� ��� null��  � �����
�� 
For_� o      ���� 0 thevalue theValue��  � k    a�� ��� l      ������  ��� Notes:
	 
	 - Most value types can be rendered using vanilla code; only specifiers and records have to be rendered via OSA APIs; values should be rendered in human-readable form (text isn't quoted, lists are concatentated as comma-separated items, dates and numbers using default AS coercions, etc) - user can use `literal representation`, `format number/date`, etc. to format values differently (avoids need for complex template parsing).
	 	- Rendering arbitrary AS values requires wrapping the value in a script object (to preserve context info such as an object specifier's target application), converting that script to a typeScript descriptor (e.g. by packing it into an Apple event and sending it to a previously installed AE handler), then loading that script into an AS component instance, executing it, and returning the result's display value. Currently this is done via TextSupport.app agent. The whole thing's ridiculously kludgy, currently isn't smart enough to load up appropriate terminology before rendering app specifiers, and really requires AppleScript to implement a proper `literal text` property on all its datatypes. But at least it should help demonstrate the need for such a feature.
	   � ���	z   N o t e s : 
 	   
 	   -   M o s t   v a l u e   t y p e s   c a n   b e   r e n d e r e d   u s i n g   v a n i l l a   c o d e ;   o n l y   s p e c i f i e r s   a n d   r e c o r d s   h a v e   t o   b e   r e n d e r e d   v i a   O S A   A P I s ;   v a l u e s   s h o u l d   b e   r e n d e r e d   i n   h u m a n - r e a d a b l e   f o r m   ( t e x t   i s n ' t   q u o t e d ,   l i s t s   a r e   c o n c a t e n t a t e d   a s   c o m m a - s e p a r a t e d   i t e m s ,   d a t e s   a n d   n u m b e r s   u s i n g   d e f a u l t   A S   c o e r c i o n s ,   e t c )   -   u s e r   c a n   u s e   ` l i t e r a l   r e p r e s e n t a t i o n ` ,   ` f o r m a t   n u m b e r / d a t e ` ,   e t c .   t o   f o r m a t   v a l u e s   d i f f e r e n t l y   ( a v o i d s   n e e d   f o r   c o m p l e x   t e m p l a t e   p a r s i n g ) . 
 	    	 -   R e n d e r i n g   a r b i t r a r y   A S   v a l u e s   r e q u i r e s   w r a p p i n g   t h e   v a l u e   i n   a   s c r i p t   o b j e c t   ( t o   p r e s e r v e   c o n t e x t   i n f o   s u c h   a s   a n   o b j e c t   s p e c i f i e r ' s   t a r g e t   a p p l i c a t i o n ) ,   c o n v e r t i n g   t h a t   s c r i p t   t o   a   t y p e S c r i p t   d e s c r i p t o r   ( e . g .   b y   p a c k i n g   i t   i n t o   a n   A p p l e   e v e n t   a n d   s e n d i n g   i t   t o   a   p r e v i o u s l y   i n s t a l l e d   A E   h a n d l e r ) ,   t h e n   l o a d i n g   t h a t   s c r i p t   i n t o   a n   A S   c o m p o n e n t   i n s t a n c e ,   e x e c u t i n g   i t ,   a n d   r e t u r n i n g   t h e   r e s u l t ' s   d i s p l a y   v a l u e .   C u r r e n t l y   t h i s   i s   d o n e   v i a   T e x t S u p p o r t . a p p   a g e n t .   T h e   w h o l e   t h i n g ' s   r i d i c u l o u s l y   k l u d g y ,   c u r r e n t l y   i s n ' t   s m a r t   e n o u g h   t o   l o a d   u p   a p p r o p r i a t e   t e r m i n o l o g y   b e f o r e   r e n d e r i n g   a p p   s p e c i f i e r s ,   a n d   r e a l l y   r e q u i r e s   A p p l e S c r i p t   t o   i m p l e m e n t   a   p r o p e r   ` l i t e r a l   t e x t `   p r o p e r t y   o n   a l l   i t s   d a t a t y p e s .   B u t   a t   l e a s t   i t   s h o u l d   h e l p   d e m o n s t r a t e   t h e   n e e d   f o r   s u c h   a   f e a t u r e . 
 	� ���� P    a���� Q   `���� k   J�� ��� l   ������  � � z caution: AS types that can have overridden `class` properties (specifiers, records, etc) must be handled as special cases   � ��� �   c a u t i o n :   A S   t y p e s   t h a t   c a n   h a v e   o v e r r i d d e n   ` c l a s s `   p r o p e r t i e s   ( s p e c i f i e r s ,   r e c o r d s ,   e t c )   m u s t   b e   h a n d l e d   a s   s p e c i a l   c a s e s� ��� Z   �������� F    3��� F    #��� =    ��� l   ������ I   �� 
�� .corecnte****       ****  J     �� o    	���� 0 thevalue theValue��   ����
�� 
kocl m    ��
�� 
obj ��  ��  ��  � m    ����  � =    ! l   ���� I   ��	
�� .corecnte****       **** J    

 �� o    ���� 0 thevalue theValue��  	 ����
�� 
kocl m    ��
�� 
capp��  ��  ��   m     ����  � =   & 1 l  & /���� I  & /��
�� .corecnte****       **** J   & ) �� o   & '���� 0 thevalue theValue��   ����
�� 
kocl m   * +��
�� 
reco��  ��  ��   m   / 0����  � Z   6� >   6 A l  6 ?���� I  6 ?��
�� .corecnte****       **** J   6 9 �� o   6 7���� 0 thevalue theValue��   �� ��
�� 
kocl  m   : ;��
�� 
scpt��  ��  ��   m   ? @����   l  D Y!"#! Q   D Y$%&$ L   G O'' b   G N()( b   G L*+* m   G H,, �--  � s c r i p t  + l  H K.����. n  H K/0/ 1   I K��
�� 
pnam0 o   H I���� 0 thevalue theValue��  ��  ) m   L M11 �22  �% R      ������
�� .ascrerr ****      � ****��  ��  & L   W Y33 m   W X44 �55  � s c r i p t �"GA script objects are currently displayed as "�script[NAME]�" (displaying script objects as source code is a separate task and should be done via OSAKit/osadecompile); TO DO: support informal 'description' protocol, speculatively calling `theValue's objectDescription()` and returning result if it's a non-empty text value?   # �66�   s c r i p t   o b j e c t s   a r e   c u r r e n t l y   d i s p l a y e d   a s   " � s c r i p t [ N A M E ] � "   ( d i s p l a y i n g   s c r i p t   o b j e c t s   a s   s o u r c e   c o d e   i s   a   s e p a r a t e   t a s k   a n d   s h o u l d   b e   d o n e   v i a   O S A K i t / o s a d e c o m p i l e ) ;   T O   D O :   s u p p o r t   i n f o r m a l   ' d e s c r i p t i o n '   p r o t o c o l ,   s p e c u l a t i v e l y   c a l l i n g   ` t h e V a l u e ' s   o b j e c t D e s c r i p t i o n ( ) `   a n d   r e t u r n i n g   r e s u l t   i f   i t ' s   a   n o n - e m p t y   t e x t   v a l u e ? 787 =  \ c9:9 n  \ _;<; m   ] _��
�� 
pcls< o   \ ]���� 0 thevalue theValue: m   _ b��
�� 
ctxt8 =>= k   f �?? @A@ r   f oBCB n  f mDED 1   i m��
�� 
txdlE 1   f i��
�� 
ascrC o      ���� 0 oldtids oldTIDsA FGF r   p {HIH m   p sJJ �KK  \I n     LML 1   v z��
�� 
txdlM 1   s v��
�� 
ascrG NON r   | �PQP n   | �RSR 2  } ���
�� 
citmS o   | }���� 0 thevalue theValueQ o      ���� 0 	textitems 	textItemsO TUT r   � �VWV m   � �XX �YY  \ \W n     Z[Z 1   � ���
�� 
txdl[ 1   � ���
�� 
ascrU \]\ r   � �^_^ c   � �`a` o   � ����� 0 	textitems 	textItemsa m   � ���
�� 
ctxt_ o      ���� 0 thevalue theValue] bcb r   � �ded m   � �ff �gg  "e n     hih 1   � ���
�� 
txdli 1   � ���
�� 
ascrc jkj r   � �lml n   � �non 2  � ���
�� 
citmo o   � ����� 0 thevalue theValuem o      ���� 0 	textitems 	textItemsk pqp r   � �rsr m   � �tt �uu  \ "s n     vwv 1   � ���
�� 
txdlw 1   � ���
�� 
ascrq xyx r   � �z{z c   � �|}| o   � ����� 0 	textitems 	textItems} m   � ���
�� 
ctxt{ o      ���� 0 thevalue theValuey ~~ r   � ���� o   � ����� 0 oldtids oldTIDs� n     ��� 1   � ���
�� 
txdl� 1   � ���
�� 
ascr ���� L   � ��� b   � ���� b   � ���� m   � ��� ���  "� o   � ����� 0 thevalue theValue� m   � ��� ���  "��  > ��� =  � ���� n  � ���� m   � ���
�� 
pcls� o   � ����� 0 thevalue theValue� m   � ���
�� 
optr� ���� l  �x���� k   �x�� ��� l  � �������  � f ` TO DO: this is kludgy; ought to be possible to load AEDesc into an OSAValueID then display that   � ��� �   T O   D O :   t h i s   i s   k l u d g y ;   o u g h t   t o   b e   p o s s i b l e   t o   l o a d   A E D e s c   i n t o   a n   O S A V a l u e I D   t h e n   d i s p l a y   t h a t� ��� Q   �m���� k   �`�� ��� r   � ���� n  � ���� I   � ��������  0 objectatindex_ objectAtIndex_� ���� m   � �����  ��  ��  � l  � ������� n  � ���� I   � �������� $0 arraywithobject_ arrayWithObject_� ���� o   � ��� 0 thevalue theValue��  ��  � n  � ���� o   � ��~�~ 0 nsarray NSArray� m   � ��}
�} misccura��  ��  � o      �|�|  0 asocdescriptor asocDescriptor� ��� r   ���� c   ���� l  ���{�z� n  ���� I   ��y��x�y &0 stringwithstring_ stringWithString_� ��w� l  ���v�u� n  ���� I  �t�s�r�t "0 uppercasestring uppercaseString�s  �r  � l  ���q�p� n  ���� I  �o�n�m�o 0 description  �n  �m  � n  ���� I   �l�k�j�l 0 data  �k  �j  � o   � �i�i  0 asocdescriptor asocDescriptor�q  �p  �v  �u  �w  �x  � n  � ���� o   � ��h�h 0 nsstring NSString� m   � ��g
�g misccura�{  �z  � m  �f
�f 
ctxt� o      �e�e 0 hextext hexText� ��� r   ��� n ��� 1  �d
�d 
txdl� 1  �c
�c 
ascr� o      �b�b 0 oldtids oldTIDs� ��� r  !,��� 1  !$�a
�a 
spac� n     ��� 1  '+�`
�` 
txdl� 1  $'�_
�_ 
ascr� ��� r  -4��� n  -2��� 2 .2�^
�^ 
citm� o  -.�]�] 0 hextext hexText� o      �\�\ 0 	textitems 	textItems� ��� r  5@��� m  58�� ���  � n     ��� 1  ;?�[
�[ 
txdl� 1  8;�Z
�Z 
ascr� ��� r  AV��� n AT��� 7 FT�Y��
�Y 
ctxt� m  LN�X�X � m  OS�W�W��� l AF��V�U� c  AF��� o  AB�T�T 0 	textitems 	textItems� m  BE�S
�S 
ctxt�V  �U  � o      �R�R 0 hextext hexText� ��Q� r  W`��� o  WX�P�P 0 oldtids oldTIDs� n     ��� 1  [_�O
�O 
txdl� 1  X[�N
�N 
ascr�Q  � R      �M�L�K
�M .ascrerr ****      � ****�L  �K  � r  hm��� m  hk�� ���  &� o      �J�J 0 hextext hexText� ��I� L  nx�� b  nw��� b  ns��� m  nq�� ���  � d a t a   o p t r� o  qr�H�H 0 hextext hexText� m  sv�� ���  ��I  �   format "�data optr...�"   � �   0   f o r m a t   " � d a t a   o p t r . . . � "��   Q  {� L  ~� c  ~� o  ~�G�G 0 thevalue theValue m  ��F
�F 
ctxt R      �E�D
�E .ascrerr ****      � ****�D   �C�B
�C 
errn d      		 m      �A�A��B   l ���@
�@  
   fall through    �    f a l l   t h r o u g h��  ��  �  l ���?�?   � � if it's an ASOC object specifier, use object's description if available otherwise create raw syntax representation of ocid specifier    �
   i f   i t ' s   a n   A S O C   o b j e c t   s p e c i f i e r ,   u s e   o b j e c t ' s   d e s c r i p t i o n   i f   a v a i l a b l e   o t h e r w i s e   c r e a t e   r a w   s y n t a x   r e p r e s e n t a t i o n   o f   o c i d   s p e c i f i e r  Z  ��>�= F  �� >  �� l ���<�; I ���:
�: .corecnte****       **** J  �� �9 o  ���8�8 0 thevalue theValue�9   �7�6
�7 
kocl m  ���5
�5 
obj �6  �<  �;   m  ���4�4   = �� !  n ��"#" m  ���3
�3 
want# l ��$�2�1$ c  ��%&% o  ���0�0 0 thevalue theValue& m  ���/
�/ 
reco�2  �1  ! m  ���.
�. 
ocid l �'()' Q  �*+,* k  ��-- ./. r  ��010 l ��2�-�,2 c  ��343 n ��565 I  ���+�*�)�+ 0 description  �*  �)  6 o  ���(�( 0 thevalue theValue4 m  ���'
�' 
ctxt�-  �,  1 o      �&�& "0 descriptiontext descriptionText/ 787 Z ��9:�%�$9 F  ��;<; C  ��=>= o  ���#�# "0 descriptiontext descriptionText> m  ��?? �@@  << D  ��ABA o  ���"�" "0 descriptiontext descriptionTextB m  ��CC �DD  >: r  ��EFE n  ��GHG 7 ���!IJ
�! 
ctxtI m  ��� �  J m  ������H o  ���� "0 descriptiontext descriptionTextF o      �� "0 descriptiontext descriptionText�%  �$  8 K�K L  ��LL b  ��MNM b  ��OPO m  ��QQ �RR  �P o  ���� "0 descriptiontext descriptionTextN m  ��SS �TT  ��  + R      ���
� .ascrerr ****      � ****�  �  , l �UVWU l �XYZX L  �[[ b  �\]\ m  ��^^ �__   � c l a s s   o c i d �   i d  ] l �`��` I ���a
� .Txt:FLitnull��� ��� null�  a �b�
� 
For_b l  c��c n  ded m  �
� 
selde l  f��f c   ghg o   �� 0 thevalue theValueh m  �
� 
reco�  �  �  �  �  �  �  Y � � would be better to get correct representation generated by OSAKit, but AS doesn't allow ASOC specifiers to travel so string-munging it is   Z �ii   w o u l d   b e   b e t t e r   t o   g e t   c o r r e c t   r e p r e s e n t a t i o n   g e n e r a t e d   b y   O S A K i t ,   b u t   A S   d o e s n ' t   a l l o w   A S O C   s p e c i f i e r s   t o   t r a v e l   s o   s t r i n g - m u n g i n g   i t   i sV V P otherwise use raw ASOC object specifier syntax (not ideal, but will have to do)   W �jj �   o t h e r w i s e   u s e   r a w   A S O C   o b j e c t   s p e c i f i e r   s y n t a x   ( n o t   i d e a l ,   b u t   w i l l   h a v e   t o   d o )( � �  (see TypesLib's `check type` handler for notes)		-- TO DO: need to check this hack (it's also used in TypesLib) as it's possible it will error on some reference objects (e.g. app specifiers)   ) �kk�     ( s e e   T y p e s L i b ' s   ` c h e c k   t y p e `   h a n d l e r   f o r   n o t e s ) 	 	 - -   T O   D O :   n e e d   t o   c h e c k   t h i s   h a c k   ( i t ' s   a l s o   u s e d   i n   T y p e s L i b )   a s   i t ' s   p o s s i b l e   i t   w i l l   e r r o r   o n   s o m e   r e f e r e n c e   o b j e c t s   ( e . g .   a p p   s p e c i f i e r s )�>  �=   lml l �
no�
  nhb TO DO: there's a problem here if value is a record containing ASOC specifiers, as there's no practical way to examine the record's properties without sending it to an AE handler, and AS will throw an error; suspect the only practical option is to throw another error that describes the problem, or return "�record�" to indicate object is unrepresentable   o �pp�   T O   D O :   t h e r e ' s   a   p r o b l e m   h e r e   i f   v a l u e   i s   a   r e c o r d   c o n t a i n i n g   A S O C   s p e c i f i e r s ,   a s   t h e r e ' s   n o   p r a c t i c a l   w a y   t o   e x a m i n e   t h e   r e c o r d ' s   p r o p e r t i e s   w i t h o u t   s e n d i n g   i t   t o   a n   A E   h a n d l e r ,   a n d   A S   w i l l   t h r o w   a n   e r r o r ;   s u s p e c t   t h e   o n l y   p r a c t i c a l   o p t i o n   i s   t o   t h r o w   a n o t h e r   e r r o r   t h a t   d e s c r i b e s   t h e   p r o b l e m ,   o r   r e t u r n   " � r e c o r d � "   t o   i n d i c a t e   o b j e c t   i s   u n r e p r e s e n t a b l em q�	q Q  Jrstr k  >uu vwv r  xyx I  �z�� (0 _makevalueiterator _makeValueIteratorz {�{ J  || }�} o  �� 0 thevalue theValue�  �  �  y o      �� 0 scpt  w ~�~ O   >� I .=�� �
� .Txt:LitR****      � ****�   � ����
�� 
Scpt� o  23���� 0 scpt  � �����
�� 
Deco� l 67������ m  67��
�� boovfals��  ��  ��  � 5   +�����
�� 
capp� o  "'���� 60 _textsupportagentbundleid _TextSupportAgentBundleID
�� kfrmID  �  s R      ������
�� .ascrerr ****      � ****��  ��  t L  FJ�� m  FI�� ��� 0 � u n r e p r e s e n t a b l e   o b j e c t ��	  � R      ����
�� .ascrerr ****      � ****� o      ���� 0 etext eText� ����
�� 
errn� o      ���� 0 enumber eNumber� ����
�� 
erob� o      ���� 0 efrom eFrom� �����
�� 
errt� o      ���� 
0 eto eTo��  � l R`���� I  R`������� 
0 _error  � ��� m  SV�� ��� , l i t e r a l   r e p r e s e n t a t i o n� ��� o  VW���� 0 etext eText� ��� o  WX���� 0 enumber eNumber� ��� o  XY���� 0 efrom eFrom� ���� o  YZ���� 
0 eto eTo��  ��  � 8 2 note: this handler should never fail, caveat bugs   � ��� d   n o t e :   t h i s   h a n d l e r   s h o u l d   n e v e r   f a i l ,   c a v e a t   b u g s� ���
�� conscase� ���
�� consdiac� ���
�� conshyph� ���
�� conspunc� ����
�� conswhit��  � ����
�� consnume��  ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i  � ���� I     ����
�� .Txt:FTxtnull���     ctxt� o      ���� 0 templatetext templateText� �����
�� 
Usin� o      ���� 0 	thevalues 	theValues��  � k    3�� ��� l     ������  � � � note: templateText uses same `$n` (where n=1-9) notation as `search text`'s replacement templates, with `\$` to escape as necessary ($ not followed by a digit will appear as-is)   � ���d   n o t e :   t e m p l a t e T e x t   u s e s   s a m e   ` $ n `   ( w h e r e   n = 1 - 9 )   n o t a t i o n   a s   ` s e a r c h   t e x t ` ' s   r e p l a c e m e n t   t e m p l a t e s ,   w i t h   ` \ $ `   t o   e s c a p e   a s   n e c e s s a r y   ( $   n o t   f o l l o w e d   b y   a   d i g i t   w i l l   a p p e a r   a s - i s )� ���� Q    3���� k   �� ��� r    ��� n   ��� I    ������� "0 aslistparameter asListParameter� ���� o    	���� 0 	thevalues 	theValues��  ��  � o    ���� 0 _supportlib _supportLib� o      ���� 0 	thevalues 	theValues� ��� r    ��� n   ��� I    ������� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_� ��� m    �� ���  \ \ . | \ $ [ 1 - 9 ]� ��� m    ����  � ���� l   ������ m    ��
�� 
msng��  ��  ��  ��  � n   ��� o    ���� *0 nsregularexpression NSRegularExpression� m    ��
�� misccura� o      ���� 
0 regexp  � ��� r    '��� n   %��� I     %������� &0 stringwithstring_ stringWithString_� ���� o     !���� 0 templatetext templateText��  ��  � n    ��� o     ���� 0 nsstring NSString� m    ��
�� misccura� o      ���� 0 
asocstring 
asocString� ��� r   ( 9��� l  ( 7������ n  ( 7��� I   ) 7������� @0 matchesinstring_options_range_ matchesInString_options_range_� ��� o   ) *���� 0 
asocstring 
asocString� ��� m   * +����  � ���� J   + 3�� ��� m   + ,����  � ���� n  , 1��� I   - 1�������� 
0 length  ��  ��  � o   , -���� 0 
asocstring 
asocString��  ��  ��  � o   ( )���� 
0 regexp  ��  ��  � o      ����  0 asocmatcharray asocMatchArray� ��� r   : >��� J   : <����  � o      ���� 0 resulttexts resultTexts� ��� r   ? B��� m   ? @����  � o      ���� 0 
startindex 
startIndex� ���� P   C���� k   H�� ��� Y   H � ����  k   X �  r   X e l  X c���� n  X c	
	 I   ^ c������ 0 rangeatindex_ rangeAtIndex_ �� m   ^ _����  ��  ��  
 l  X ^���� n  X ^ I   Y ^������  0 objectatindex_ objectAtIndex_ �� o   Y Z���� 0 i  ��  ��   o   X Y����  0 asocmatcharray asocMatchArray��  ��  ��  ��   o      ���� 0 
matchrange 
matchRange  r   f � c   f } l  f y���� n  f y I   g y������ *0 substringwithrange_ substringWithRange_ �� K   g u ���� 0 location   o   h i���� 0 
startindex 
startIndex �� ���� 
0 length    l  j q!����! \   j q"#" l  j o$����$ n  j o%&% I   k o�������� 0 location  ��  ��  & o   j k���� 0 
matchrange 
matchRange��  ��  # o   o p���� 0 
startindex 
startIndex��  ��  ��  ��  ��   o   f g���� 0 
asocstring 
asocString��  ��   m   y |�
� 
ctxt n      '('  ;   ~ ( o   } ~�~�~ 0 resulttexts resultTexts )*) r   � �+,+ c   � �-.- l  � �/�}�|/ n  � �010 I   � ��{2�z�{ *0 substringwithrange_ substringWithRange_2 3�y3 o   � ��x�x 0 
matchrange 
matchRange�y  �z  1 o   � ��w�w 0 
asocstring 
asocString�}  �|  . m   � ��v
�v 
ctxt, o      �u�u 0 thetoken theToken* 454 Z   � �67�t86 =  � �9:9 o   � ��s�s 0 thetoken theToken: m   � �;; �<<  \ \7 l  � �=>?= r   � �@A@ o   � ��r�r 0 thetoken theTokenA n      BCB  ;   � �C o   � ��q�q 0 resulttexts resultTexts> ( " found backslash-escaped character   ? �DD D   f o u n d   b a c k s l a s h - e s c a p e d   c h a r a c t e r�t  8 l  � �EFGE k   � �HH IJI l  � �KLMK r   � �NON n   � �PQP 4   � ��pR
�p 
cobjR l  � �S�o�nS c   � �TUT n  � �VWV 4  � ��mX
�m 
cha X m   � ��l�l��W o   � ��k�k 0 thetoken theTokenU m   � ��j
�j 
long�o  �n  Q o   � ��i�i 0 	thevalues 	theValuesO o      �h�h 0 theitem theItemL 2 , this will raise error -1728 if out of range   M �YY X   t h i s   w i l l   r a i s e   e r r o r   - 1 7 2 8   i f   o u t   o f   r a n g eJ Z�gZ Q   � �[\][ r   � �^_^ c   � �`a` o   � ��f�f 0 theitem theItema m   � ��e
�e 
ctxt_ n      bcb  ;   � �c o   � ��d�d 0 resulttexts resultTexts\ R      �c�bd
�c .ascrerr ****      � ****�b  d �ae�`
�a 
errne d      ff m      �_�_��`  ] l  � �ghig r   � �jkj I  � ��^�]l
�^ .Txt:FLitnull��� ��� null�]  l �\m�[
�\ 
For_m o   � ��Z�Z 0 theitem theItem�[  k n      non  ;   � �o o   � ��Y�Y 0 resulttexts resultTextsh � � TO DO: or just throw 'unsupported object type' error, requiring user to get value's literal representation before passing it to `format text`   i �pp   T O   D O :   o r   j u s t   t h r o w   ' u n s u p p o r t e d   o b j e c t   t y p e '   e r r o r ,   r e q u i r i n g   u s e r   t o   g e t   v a l u e ' s   l i t e r a l   r e p r e s e n t a t i o n   b e f o r e   p a s s i n g   i t   t o   ` f o r m a t   t e x t `�g  F  	 found $n   G �qq    f o u n d   $ n5 r�Xr r   � �sts [   � �uvu l  � �w�W�Vw n  � �xyx I   � ��U�T�S�U 0 location  �T  �S  y o   � ��R�R 0 
matchrange 
matchRange�W  �V  v l  � �z�Q�Pz n  � �{|{ I   � ��O�N�M�O 
0 length  �N  �M  | o   � ��L�L 0 
matchrange 
matchRange�Q  �P  t o      �K�K 0 
startindex 
startIndex�X  �� 0 i   m   K L�J�J   l  L S}�I�H} \   L S~~ l  L Q��G�F� n  L Q��� I   M Q�E�D�C�E 	0 count  �D  �C  � o   L M�B�B  0 asocmatcharray asocMatchArray�G  �F   m   Q R�A�A �I  �H  ��  � ��� r   � ���� c   � ���� l  � ���@�?� n  � ���� I   � ��>��=�> *0 substringfromindex_ substringFromIndex_� ��<� o   � ��;�; 0 
startindex 
startIndex�<  �=  � o   � ��:�: 0 
asocstring 
asocString�@  �?  � m   � ��9
�9 
ctxt� n      ���  ;   � �� o   � ��8�8 0 resulttexts resultTexts� ��� r   � ���� n  � ���� 1   � ��7
�7 
txdl� 1   � ��6
�6 
ascr� o      �5�5 0 oldtids oldTIDs� ��� r   ���� m   � ��� ���  � n     ��� 1   �4
�4 
txdl� 1   � �3
�3 
ascr� ��� r  ��� c  ��� o  �2�2 0 resulttexts resultTexts� m  
�1
�1 
ctxt� o      �0�0 0 
resulttext 
resultText� ��� r  ��� o  �/�/ 0 oldtids oldTIDs� n     ��� 1  �.
�. 
txdl� 1  �-
�- 
ascr� ��,� L  �� o  �+�+ 0 
resulttext 
resultText�,  � �*�
�* conscase� �)�
�) consdiac� �(�
�( conshyph� �'�
�' conspunc� �&�%
�& conswhit�%  � �$�#
�$ consnume�#  ��  � R      �"��
�" .ascrerr ****      � ****� o      �!�! 0 etext eText� � ��
�  
errn� o      �� 0 enumber eNumber� ���
� 
erob� o      �� 0 efrom eFrom� ���
� 
errt� o      �� 
0 eto eTo�  � I  #3���� 
0 _error  � ��� m  $'�� ���  f o r m a t   t e x t� ��� o  '(�� 0 etext eText� ��� o  ()�� 0 enumber eNumber� ��� o  )*�� 0 efrom eFrom� ��� o  *-�� 
0 eto eTo�  �  ��  � ��� l     ����  �  �  � ��� l     ����  �  �  � ��� l     ���
�  �  �
  � ��� l     �	���	  � J D--------------------------------------------------------------------   � ��� � - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -� ��� l     ����  ��� locale support -- TO DO: what other functionality should be exposed to user? if there's much more, consider moving to its own library (UtilitiesLib?); bear in mind that NSLocale instances and other Cocoa objects generally shouldn't be returned to user as ASOC objects cause problems for autosave, script persistence, etc; instead, use localeIdentifier strings and convert to/from NSLocale at point of use   � ���*   l o c a l e   s u p p o r t   - -   T O   D O :   w h a t   o t h e r   f u n c t i o n a l i t y   s h o u l d   b e   e x p o s e d   t o   u s e r ?   i f   t h e r e ' s   m u c h   m o r e ,   c o n s i d e r   m o v i n g   t o   i t s   o w n   l i b r a r y   ( U t i l i t i e s L i b ? ) ;   b e a r   i n   m i n d   t h a t   N S L o c a l e   i n s t a n c e s   a n d   o t h e r   C o c o a   o b j e c t s   g e n e r a l l y   s h o u l d n ' t   b e   r e t u r n e d   t o   u s e r   a s   A S O C   o b j e c t s   c a u s e   p r o b l e m s   f o r   a u t o s a v e ,   s c r i p t   p e r s i s t e n c e ,   e t c ;   i n s t e a d ,   u s e   l o c a l e I d e n t i f i e r   s t r i n g s   a n d   c o n v e r t   t o / f r o m   N S L o c a l e   a t   p o i n t   o f   u s e� ��� l     ����  �  �  � ��� i  � ���� I     ���
� .Txt:LLocnull��� ��� null�  �  � l    ���� L     �� c     ��� l    ��� � n    ��� I    ������� 60 sortedarrayusingselector_ sortedArrayUsingSelector_� ���� m    �� ���  c o m p a r e :��  ��  � n    ��� I    �������� 80 availablelocaleidentifiers availableLocaleIdentifiers��  ��  � n    ��� o    ���� 0 nslocale NSLocale� m     ��
�� misccura�  �   � m    ��
�� 
list� , &> {"af", "af_NA", "af_ZA", "agq", ...}   � ��� L >   { " a f " ,   " a f _ N A " ,   " a f _ Z A " ,   " a g q " ,   . . . }� ��� l     ��������  ��  ��  � ��� i  � ���� I     ������
�� .Txt:CLocnull��� ��� null��  ��  � L     �� c     ��� l    ������ n    ��� I    �������� $0 localeidentifier localeIdentifier��  ��  � n    ��� I    �������� 0 currentlocale currentLocale��  ��  � n    ��� o    ���� 0 nslocale NSLocale� m     ��
�� misccura��  ��  � m    ��
�� 
ctxt� ��� l     ��������  ��  ��  � ���� l     ��������  ��  ��  ��       '���� ������ 	
��  � %��������������������������������������������������������������������������
�� 
pimr�� 60 _textsupportagentbundleid _TextSupportAgentBundleID�� (0 _unmatchedtexttype _UnmatchedTextType�� $0 _matchedtexttype _MatchedTextType�� &0 _matchedgrouptype _MatchedGroupType�� 0 _supportlib _supportLib�� 
0 _error  �� 60 _compileregularexpression _compileRegularExpression�� $0 _matchinforecord _matchInfoRecord�� 0 _matchrecords _matchRecords�� &0 _matchedgrouplist _matchedGroupList�� 0 _findpattern _findPattern�� "0 _replacepattern _replacePattern�� 0 	_findtext 	_findText�� 0 _replacetext _replaceText
�� .Txt:Srchnull���     ctxt
�� .Txt:EPatnull���     ctxt
�� .Txt:ETemnull���     ctxt�� 0 	_pinindex 	_pinIndex
�� .Txt:UppTnull���     ctxt
�� .Txt:CapTnull���     ctxt
�� .Txt:LowTnull���     ctxt
�� .Txt:PadTnull���     ctxt
�� .Txt:SliTnull���     ctxt
�� .Txt:TrmTnull���     ctxt�� 0 
_splittext 
_splitText�� 0 _splitpattern _splitPattern�� 0 	_jointext 	_joinText
�� .Txt:SplTnull���     ctxt
�� .Txt:JoiTnull���     ****
�� .Txt:SplPnull���     ctxt
�� .Txt:JoiPnull���     ****�� (0 _makevalueiterator _makeValueIterator
�� .Txt:FLitnull��� ��� null
�� .Txt:FTxtnull���     ctxt
�� .Txt:LLocnull��� ��� null
�� .Txt:CLocnull��� ��� null� �� ��    !! ��"��
�� 
cobj" ##   �� 
�� 
frmk��  
�� 
TxtU
�� 
TxtM
�� 
TxtG  $$   �� L
�� 
scpt �� V����%&���� 
0 _error  �� ��'�� '  ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo��  % ������������ 0 handlername handlerName�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo&  f������ �� &0 throwcommanderror throwCommandError�� b  ࠡ����+  �� �����()���� 60 _compileregularexpression _compileRegularExpression�� ��*�� *  ���� 0 patterntext patternText��  ( ������ 0 patterntext patternText�� 
0 regexp  ) 	���������������� �
�� misccura�� *0 nsregularexpression NSRegularExpression
�� 
msng�� Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_
�� 
errn���Y
�� 
erob�� �� #��,�j�m+ E�O��  )�����Y hO� �� �����+,���� $0 _matchinforecord _matchInfoRecord�� ��-�� -  ���������� 0 
asocstring 
asocString��  0 asocmatchrange asocMatchRange�� 0 
textoffset 
textOffset�� 0 
recordtype 
recordType��  + �������������� 0 
asocstring 
asocString��  0 asocmatchrange asocMatchRange�� 0 
textoffset 
textOffset�� 0 
recordtype 
recordType�� 0 	foundtext 	foundText��  0 nexttextoffset nextTextOffset, ����~�}�|�{�z�y�� *0 substringwithrange_ substringWithRange_
� 
ctxt
�~ 
leng
�} 
pcls�| 0 
startindex 
startIndex�{ 0 endindex endIndex�z 0 	foundtext 	foundText�y �� $��k+  �&E�O���,E�O���k���lv �x ��w�v./�u�x 0 _matchrecords _matchRecords�w �t0�t 0  �s�r�q�p�o�n�s 0 
asocstring 
asocString�r  0 asocmatchrange asocMatchRange�q  0 asocstartindex asocStartIndex�p 0 
textoffset 
textOffset�o (0 nonmatchrecordtype nonMatchRecordType�n "0 matchrecordtype matchRecordType�v  . �m�l�k�j�i�h�g�f�e�d�c�m 0 
asocstring 
asocString�l  0 asocmatchrange asocMatchRange�k  0 asocstartindex asocStartIndex�j 0 
textoffset 
textOffset�i (0 nonmatchrecordtype nonMatchRecordType�h "0 matchrecordtype matchRecordType�g  0 asocmatchstart asocMatchStart�f 0 asocmatchend asocMatchEnd�e &0 asocnonmatchrange asocNonMatchRange�d 0 nonmatchinfo nonMatchInfo�c 0 	matchinfo 	matchInfo/ �b�a�`�_�^�b 0 location  �a 
0 length  �` �_ $0 _matchinforecord _matchInfoRecord
�^ 
cobj�u W�j+  E�O��j+ E�O�ᦢ�E�O*�����+ E[�k/E�Z[�l/E�ZO*�����+ E[�k/E�Z[�l/E�ZO�����v �]S�\�[12�Z�] &0 _matchedgrouplist _matchedGroupList�\ �Y3�Y 3  �X�W�V�U�X 0 
asocstring 
asocString�W 0 	asocmatch 	asocMatch�V 0 
textoffset 
textOffset�U &0 includenonmatches includeNonMatches�[  1 �T�S�R�Q�P�O�N�M�L�K�J�I�H�T 0 
asocstring 
asocString�S 0 	asocmatch 	asocMatch�R 0 
textoffset 
textOffset�Q &0 includenonmatches includeNonMatches�P "0 submatchresults subMatchResults�O 0 groupindexes groupIndexes�N (0 asocfullmatchrange asocFullMatchRange�M &0 asocnonmatchstart asocNonMatchStart�L $0 asocfullmatchend asocFullMatchEnd�K 0 i  �J 0 nonmatchinfo nonMatchInfo�I 0 	matchinfo 	matchInfo�H &0 asocnonmatchrange asocNonMatchRange2 	�G�F�E�D�C�B�A�@�?�G  0 numberofranges numberOfRanges�F 0 rangeatindex_ rangeAtIndex_�E 0 location  �D 
0 length  �C �B 0 _matchrecords _matchRecords
�A 
cobj�@ �? $0 _matchinforecord _matchInfoRecord�Z �jvE�O�j+  kE�O�j ��jk+ E�O�j+ E�O��j+ E�O Uk�kh 	*���k+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO��6F[OY��O� #�㨧�E�O*���b  �+ �k/�6FY hY hO� �>��=�<45�;�> 0 _findpattern _findPattern�= �:6�: 6  �9�8�7�6�9 0 thetext theText�8 0 patterntext patternText�7 &0 includenonmatches includeNonMatches�6  0 includematches includeMatches�<  4 �5�4�3�2�1�0�/�.�-�,�+�*�)�(�'�5 0 thetext theText�4 0 patterntext patternText�3 &0 includenonmatches includeNonMatches�2  0 includematches includeMatches�1 
0 regexp  �0 0 
asocstring 
asocString�/ &0 asocnonmatchstart asocNonMatchStart�. 0 
textoffset 
textOffset�- 0 
resultlist 
resultList�,  0 asocmatcharray asocMatchArray�+ 0 i  �* 0 	asocmatch 	asocMatch�) 0 nonmatchinfo nonMatchInfo�( 0 	matchinfo 	matchInfo�' 0 	foundtext 	foundText5 ��& �%�$�#�"�!� ������������������& (0 asbooleanparameter asBooleanParameter�% 60 _compileregularexpression _compileRegularExpression
�$ misccura�# 0 nsstring NSString�" &0 stringwithstring_ stringWithString_�! 
0 length  �  @0 matchesinstring_options_range_ matchesInString_options_range_� 	0 count  �  0 objectatindex_ objectAtIndex_� 0 rangeatindex_ rangeAtIndex_� � 0 _matchrecords _matchRecords
� 
cobj� � 0 foundgroups foundGroups� 0 
startindex 
startIndex� &0 _matchedgrouplist _matchedGroupList� *0 substringfromindex_ substringFromIndex_
� 
ctxt
� 
pcls� 0 endindex endIndex
� 
leng� 0 	foundtext 	foundText� �;b  ��l+ E�Ob  ��l+ E�O*�k+ E�O��,�k+ E�OjE�OkE�OjvE�O��jj�j+ lvm+ E�O j�j+ 	kkh 
��k+ 
E�O*��jk+ ��b  b  �+ E[�k/E�Z[�l/E�Z[�m/E�Z[��/E�ZO� 	��6FY hO� �a *���a ,��+ l%�6FY h[OY��O� 1��k+ a &E�Oa b  a �a �a ,a �a �6FY hO� ����78�� "0 _replacepattern _replacePattern� �
9�
 9  �	���	 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText�  7 ������ 0 thetext theText� 0 patterntext patternText� 0 templatetext templateText� 0 
asocstring 
asocString� 
0 regexp  8 �� ����������
� misccura�  0 nsstring NSString�� &0 stringwithstring_ stringWithString_�� 60 _compileregularexpression _compileRegularExpression�� 
0 length  �� �� |0 <stringbyreplacingmatchesinstring_options_range_withtemplate_ <stringByReplacingMatchesInString_options_range_withTemplate_� &��,�k+ E�O*�k+ E�O��jj�j+ lv��+  ������:;���� 0 	_findtext 	_findText�� ��<�� <  ���������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches��  : 
���������������������� 0 thetext theText�� 0 fortext forText�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 
resultlist 
resultList�� 0 oldtids oldTIDs�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 0 i  ; &��������*����������\������������������
�� 
errn���Y
�� 
erob�� 
�� 
ascr
�� 
txdl
�� 
citm
�� 
leng
�� 
ctxt
�� 
pcls�� 0 
startindex 
startIndex�� 0 endindex endIndex�� 0 	foundtext 	foundText�� 
�� .corecnte****       ****�� 0 foundgroups foundGroups�� 
��(��  )�����Y hOjvE�O��,E�O���,FOkE�O��k/�,E�O�� �[�\[Z�\Z�2E�Y �E�O� �b  ����a �6FY hO �l��-j kh 	�kE�O��,�[�\[�/\Zi2�,E�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a jva �6FY hO�kE�O���/�,kE�O�� �[�\[Z�\Z�2E�Y a E�O� �b  ����a �6FY h[OY�XO���,FO�	 ������=>���� 0 _replacetext _replaceText�� ��?�� ?  �������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText��  = �������������� 0 thetext theText�� 0 fortext forText�� 0 newtext newText�� 0 oldtids oldTIDs�� 0 	textitems 	textItems�� 0 
resulttext 
resultText> ��������
�� 
ascr
�� 
txdl
�� 
citm
�� 
ctxt�� '��,E�O���,FO��-E�O���,FO��&E�O���,FO�
 ��A����@A��
�� .Txt:Srchnull���     ctxt�� 0 thetext theText�� ����B
�� 
For_�� 0 fortext forTextB ��CD
�� 
UsinC {�������� 0 matchformat matchFormat��  
�� SerECmpID ��EF
�� 
ReplE {�������� 0 newtext newText��  
�� 
msngF ��G��
�� 
RetuG {�������� 0 resultformat resultFormat��  
�� RetEMatT��  @ ������������������������ 0 thetext theText�� 0 fortext forText�� 0 matchformat matchFormat�� 0 newtext newText�� 0 resultformat resultFormat�� &0 includenonmatches includeNonMatches��  0 includematches includeMatches�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToA #c��r��������������������������������������(����r��H������ "0 astextparameter asTextParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� 
msng
�� RetEMatT
�� 
cobj
�� RetEUmaT
�� RetEAllT�� >0 throwinvalidparameterconstant throwInvalidParameterConstant
�� SerECmpI�� 0 	_findtext 	_findText
�� SerECmpP�� 0 _findpattern _findPattern
�� SerECmpC
�� SerECmpD�� 0 _replacetext _replaceText�� "0 _replacepattern _replacePattern�� 0 etext eTextH ��I
� 
errn� 0 enumber eNumberI ��J
� 
erob� 0 efrom eFromJ ���
� 
errt� 
0 eto eTo�  �� �� 
0 _error  ����b  ��l+ E�Ob  ��l+ E�O��,j  )�����Y hO��  ؤ�  felvE[�k/E�Z[�l/E�ZY E��  eflvE[�k/E�Z[�l/E�ZY )��  eelvE[�k/E�Z[�l/E�ZY b  ��l+ O�a   a a  *�����+ VY V�a   *�����+ Y A�a   a g *�����+ VY $�a   *�����+ Y b  �a l+ Y �b  �a l+ E�O�a   a a  *���m+ VY S�a   *���m+ Y ?�a   a g *���m+ VY #�a   *���m+ Y b  �a l+ W X  *a  ����a !+ " ����KL�
� .Txt:EPatnull���     ctxt� 0 thetext theText�  K ������ 0 thetext theText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eToL ��~��}�|�{�zM��y�x
� misccura�~ *0 nsregularexpression NSRegularExpression�} "0 astextparameter asTextParameter�| 40 escapedpatternforstring_ escapedPatternForString_
�{ 
ctxt�z 0 etext eTextM �w�vN
�w 
errn�v 0 enumber eNumberN �u�tO
�u 
erob�t 0 efrom eFromO �s�r�q
�s 
errt�r 
0 eto eTo�q  �y �x 
0 _error  � + ��,b  ��l+ k+ �&W X  *衢���+ 
 �p��o�nPQ�m
�p .Txt:ETemnull���     ctxt�o 0 thetext theText�n  P �l�k�j�i�h�l 0 thetext theText�k 0 etext eText�j 0 enumber eNumber�i 0 efrom eFrom�h 
0 eto eToQ �g�f��e�d�c�bR��a�`
�g misccura�f *0 nsregularexpression NSRegularExpression�e "0 astextparameter asTextParameter�d 60 escapedtemplateforstring_ escapedTemplateForString_
�c 
ctxt�b 0 etext eTextR �_�^S
�_ 
errn�^ 0 enumber eNumberS �]�\T
�] 
erob�\ 0 efrom eFromT �[�Z�Y
�[ 
errt�Z 
0 eto eTo�Y  �a �` 
0 _error  �m + ��,b  ��l+ k+ �&W X  *衢���+ 
 �X��W�VUV�U�X 0 	_pinindex 	_pinIndex�W �TW�T W  �S�R�S 0 theindex theIndex�R 0 
textlength 
textLength�V  U �Q�P�Q 0 theindex theIndex�P 0 
textlength 
textLengthV  �U &�� �Y ��' �'Y �j  kY � �O-�N�MXY�L
�O .Txt:UppTnull���     ctxt�N 0 thetext theText�M �KZ�J
�K 
LocaZ {�I�H�G�I 0 
localecode 
localeCode�H  
�G 
msng�J  X �F�E�D�C�B�A�@�F 0 thetext theText�E 0 
localecode 
localeCode�D 0 
asocstring 
asocString�C 0 etext eText�B 0 enumber eNumber�A 0 efrom eFrom�@ 
0 eto eToY �?�>G�=�<�;�:�9f�8�7�6[r�5�4
�? misccura�> 0 nsstring NSString�= "0 astextparameter asTextParameter�< &0 stringwithstring_ stringWithString_
�; 
msng�: "0 uppercasestring uppercaseString
�9 
ctxt�8 &0 aslocaleparameter asLocaleParameter�7 80 uppercasestringwithlocale_ uppercaseStringWithLocale_�6 0 etext eText[ �3�2\
�3 
errn�2 0 enumber eNumber\ �1�0]
�1 
erob�0 0 efrom eFrom] �/�.�-
�/ 
errt�. 
0 eto eTo�-  �5 �4 
0 _error  �L O >��,b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ 	k+ 
�&W X  *������+  �,��+�*^_�)
�, .Txt:CapTnull���     ctxt�+ 0 thetext theText�* �(`�'
�( 
Loca` {�&�%�$�& 0 
localecode 
localeCode�%  
�$ 
msng�'  ^ �#�"�!� ����# 0 thetext theText�" 0 
localecode 
localeCode�! 0 
asocstring 
asocString�  0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo_ ������������a���
� misccura� 0 nsstring NSString� "0 astextparameter asTextParameter� &0 stringwithstring_ stringWithString_
� 
msng� &0 capitalizedstring capitalizedString
� 
ctxt� &0 aslocaleparameter asLocaleParameter� <0 capitalizedstringwithlocale_ capitalizedStringWithLocale_� 0 etext eTexta ��b
� 
errn� 0 enumber eNumberb ��c
� 
erob� 0 efrom eFromc ���

� 
errt� 
0 eto eTo�
  � � 
0 _error  �) O >��,b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ 	k+ 
�&W X  *������+  �	���de�
�	 .Txt:LowTnull���     ctxt� 0 thetext theText� �f�
� 
Locaf {���� 0 
localecode 
localeCode�  
� 
msng�  d � �������������  0 thetext theText�� 0 
localecode 
localeCode�� 0 
asocstring 
asocString�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eToe ���������������������g����
�� misccura�� 0 nsstring NSString�� "0 astextparameter asTextParameter�� &0 stringwithstring_ stringWithString_
�� 
msng�� "0 lowercasestring lowercaseString
�� 
ctxt�� &0 aslocaleparameter asLocaleParameter�� 80 lowercasestringwithlocale_ lowercaseStringWithLocale_�� 0 etext eTextg ����h
�� 
errn�� 0 enumber eNumberh ����i
�� 
erob�� 0 efrom eFromi ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � O >��,b  ��l+ k+ E�O��  �j+ �&Y �b  ��l+ 	k+ 
�&W X  *������+  ��,����jk��
�� .Txt:PadTnull���     ctxt�� 0 thetext theText�� ����l
�� 
toPl�� 0 toplaces toPlacesl ��mn
�� 
Charm {����5�� 0 padchar padChar��  n ��o��
�� 
Fromo {�������� 0 whichend whichEnd��  
�� LeTrLCha��  j 
���������������������� 0 thetext theText�� 0 toplaces toPlaces�� 0 padchar padChar�� 0 whichend whichEnd�� 0 	charcount 	charCount�� 0 padtext padText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTok P��\����x����������������������p������� "0 astextparameter asTextParameter�� (0 asintegerparameter asIntegerParameter
�� 
leng
�� 
errn���Y
�� 
erob�� 
�� LeTrLCha
�� 
ctxt
�� LeTrTCha
�� LeTrBCha�� >0 throwinvalidparameterconstant throwInvalidParameterConstant�� 0 etext eTextp ��q
� 
errn� 0 enumber eNumberq ��r
� 
erob� 0 efrom eFromr ���
� 
errt� 
0 eto eTo�  �� �� 
0 _error  �� � �b  ��l+ E�Ob  ��l+ E�O���,E�O�j �Y hOb  ��l+ E�O��,j  )�����Y hO h��,���%E�[OY��O��  �[�\[Zk\Z�2�%Y a��  ��[�\[Zk\Z�2%Y J��  9�k  ��[�\[Zk\Z�2%Y �[�\[Zk\Z�l"2�%�%[�\[Zk\Z�2EY b  ��l+ W X  *a ����a +  ����st�
� .Txt:SliTnull���     ctxt� 0 thetext theText� �uv
� 
Idx1u {���� 0 
startindex 
startIndex�  � v �w�
� 
Idx2w {���� 0 endindex endIndex�  ����  s �������� 0 thetext theText� 0 
startindex 
startIndex� 0 endindex endIndex� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTot ��<��N��xc��� "0 astextparameter asTextParameter
� 
leng� (0 asintegerparameter asIntegerParameter� 0 	_pinindex 	_pinIndex
� 
ctxt� 0 etext eTextx ��y
� 
errn� 0 enumber eNumbery ��z
� 
erob� 0 efrom eFromz ���
� 
errt� 
0 eto eTo�  � � 
0 _error  � l [b  ��l+ E�O��,j  �Y hO*b  ��l+ ��,l+ E�O*b  ��l+ ��,l+ E�O�[�\[Z�\Z�2EW X 	 
*룤���+  �s��{|�
� .Txt:TrmTnull���     ctxt� 0 thetext theText� �}�
� 
From} {���� 0 whichend whichEnd�  
� LeTrBCha�  { ��������� 0 thetext theText� 0 whichend whichEnd� 0 
startindex 
startIndex� 0 endindex endIndex� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo| �������������~���}�|~	�{�z� "0 astextparameter asTextParameter
� LeTrLCha
� LeTrTCha
� LeTrBCha� >0 throwinvalidparameterconstant throwInvalidParameterConstant
� 
cobj
�~ 
cha 
�} 
ctxt�| 0 etext eText~ �y�x
�y 
errn�x 0 enumber eNumber �w�v�
�w 
erob�v 0 efrom eFrom� �u�t�s
�u 
errt�t 
0 eto eTo�s  �{ �z 
0 _error  � � �b  ��l+ E�O���mv�kv b  ��l+ Y hO�� {��  �Y hOkilvE[�k/E�Z[�l/E�ZO��lv�kv  h��/� �kE�[OY��Y hO��lv�kv  h��/� �kE�[OY��Y hO�[�\[Z�\Z�2EVW X  *a ����a +  �r	#�q�p���o�r 0 
_splittext 
_splitText�q �n��n �  �m�l�m 0 thetext theText�l 0 theseparator theSeparator�p  � �k�j�i�h�g�f�k 0 thetext theText�j 0 theseparator theSeparator�i 0 delimiterlist delimiterList�h 0 aref aRef�g 0 oldtids oldTIDs�f 0 
resultlist 
resultList� �e�d�c�b�a�`�_�	T	X�^�]�\�[�Z�Y�e "0 aslistparameter asListParameter
�d 
kocl
�c 
cobj
�b .corecnte****       ****
�a 
pcnt
�` 
ctxt�_  � �X�W�V
�X 
errn�W�\�V  
�^ 
list�] �\ 60 throwinvalidparametertype throwInvalidParameterType
�[ 
ascr
�Z 
txdl
�Y 
citm�o _b  �k+  E�O 5�[��l kh  ��,�&��,FW X  b  �����+ [OY��O��,E�O���,FO��-E�O���,FO� �U	~�T�S���R�U 0 _splitpattern _splitPattern�T �Q��Q �  �P�O�P 0 thetext theText�O 0 patterntext patternText�S  � 
�N�M�L�K�J�I�H�G�F�E�N 0 thetext theText�M 0 patterntext patternText�L 
0 regexp  �K 0 
asocstring 
asocString�J &0 asocnonmatchstart asocNonMatchStart�I 0 
resultlist 
resultList�H  0 asocmatcharray asocMatchArray�G 0 i  �F  0 asocmatchrange asocMatchRange�E  0 asocmatchstart asocMatchStart� �D�C�B�A�@�?�>�=�<�;�:�9�8�7�D 60 _compileregularexpression _compileRegularExpression
�C misccura�B 0 nsstring NSString�A &0 stringwithstring_ stringWithString_�@ 
0 length  �? @0 matchesinstring_options_range_ matchesInString_options_range_�> 	0 count  �=  0 objectatindex_ objectAtIndex_�< 0 rangeatindex_ rangeAtIndex_�; 0 location  �: �9 *0 substringwithrange_ substringWithRange_
�8 
ctxt�7 *0 substringfromindex_ substringFromIndex_�R �*�k+  E�O��,�k+ E�OjE�OjvE�O��jj�j+ lvm+ E�O Fj�j+ kkh ��k+ jk+ E�O�j+ 	E�O��䩤�k+ �&�6FO��j+ E�[OY��O��k+ �&�6FO� �6
�5�4���3�6 0 	_jointext 	_joinText�5 �2��2 �  �1�0�1 0 thelist theList�0 0 separatortext separatorText�4  � �/�.�-�,�+�/ 0 thelist theList�. 0 separatortext separatorText�- 0 oldtids oldTIDs�, 0 delimiterlist delimiterList�+ 0 
resulttext 
resultText� �*�)�(�'�&��%�$�#�"�!� 
<
�* 
ascr
�) 
txdl�( "0 aslistparameter asListParameter
�' 
ctxt�&  � ���
� 
errn��\�  
�% 
errn�$�Y
�# 
erob
�" 
errt
�! 
list�  �3 ?��,E�O���,FO b  �k+ �&E�W X  ���,FO)�������O���,FO� �
Y�����
� .Txt:SplTnull���     ctxt� 0 thetext theText� ���
� 
Sepa� {���� 0 theseparator theSeparator�  
� 
msng� ���
� 
Usin� {���� 0 matchformat matchFormat�  
� SerECmpI�  � ������
�	� 0 thetext theText� 0 theseparator theSeparator� 0 matchformat matchFormat� 0 etext eText� 0 enumber eNumber�
 0 efrom eFrom�	 
0 eto eTo� 
z��
���
�
���
��
��
�� ���
������ "0 astextparameter asTextParameter
� 
msng� 0 _splitpattern _splitPattern
� SerECmpI� 0 
_splittext 
_splitText
� SerECmpP
� SerECmpC
� SerECmpD�  >0 throwinvalidparameterconstant throwInvalidParameterConstant�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  � � �b  ��l+ E�O��  *��l+ Y g��  �� *��l+ VY P��  *�b  ��l+ l+ Y 5��  �g *��l+ VY ��  *��l+ Y b  ��l+ W X  *a ����a +  ��
���������
�� .Txt:JoiTnull���     ****�� 0 thelist theList�� �����
�� 
Sepa� {����
��� 0 separatortext separatorText��  ��  � �������������� 0 thelist theList�� 0 separatortext separatorText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� ������������� "0 astextparameter asTextParameter�� 0 	_jointext 	_joinText�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� ( *�b  ��l+ l+ W X  *墣���+  ��#��������
�� .Txt:SplPnull���     ctxt�� 0 thetext theText��  � ������������ 0 thetext theText�� 0 etext eText�� 0 enumber eNumber�� 0 efrom eFrom�� 
0 eto eTo� 1�������=������ "0 astextparameter asTextParameter
�� 
cpar�� 0 etext eText� �����
�� 
errn�� 0 enumber eNumber� �����
�� 
erob�� 0 efrom eFrom� ������
�� 
errt�� 
0 eto eTo��  �� �� 
0 _error  �� % b  ��l+ �-EW X  *塢���+  ��M��������
�� .Txt:JoiPnull���     ****�� 0 thelist theList�� �����
�� 
LiBr� {������ 0 linebreaktype lineBreakType�  
� LiBrLiOX��  � �������� 0 thelist theList� 0 linebreaktype lineBreakType� 0 separatortext separatorText� 0 etext eText� 0 enumber eNumber� 0 efrom eFrom� 
0 eto eTo� �����y�������
� LiBrLiOX
� 
lnfd
� LiBrLiCM
� 
ret 
� LiBrLiWi� >0 throwinvalidparameterconstant throwInvalidParameterConstant� 0 	_jointext 	_joinText� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ���
� 
erob� 0 efrom eFrom� ���
� 
errt� 
0 eto eTo�  � � 
0 _error  �� P ?��  �E�Y '��  �E�Y ��  
��%E�Y b  ��l+ O*��l+ W X  	*꣤���+  �������� (0 _makevalueiterator _makeValueIterator� ��� �  �� 0 
objectlist 
objectList�  � ��� 0 
objectlist 
objectList� 0 scpt  � ���� 0 scpt  � �������
� .ascrinit****      � ****� k     �� ��� ��� ���  �  �  � ���� 0 _objects  � 0 i  
� .aevtoappnull  �   � ****� ����
� 
list� 0 _objects  � 0 i  � �������
� .aevtoappnull  �   � ****�  �  �  � ����
� 
leng
� 
errn��
� 
cobj� 8b  kEc  Ob  b   �, )��lhY hOb   �b  /E� b   �&�Oj�OL � ��K S� �������
� .Txt:FLitnull��� ��� null�  � ���
� 
For_� 0 thevalue theValue�  � �����~�}�|�{�z�y�x� 0 thevalue theValue� 0 oldtids oldTIDs� 0 	textitems 	textItems�  0 asocdescriptor asocDescriptor�~ 0 hextext hexText�} "0 descriptiontext descriptionText�| 0 scpt  �{ 0 etext eText�z 0 enumber eNumber�y 0 efrom eFrom�x 
0 eto eTo� A���w�v�u�t�s�r�q,�p1�o�n4�m�l�k�jJ�iXft���h�g�f�e�d�c�b�a�`�_�^��]�����\�[?CQS^�Z�Y�X�W�V�U�T�S�R��Q���P�O
�w 
kocl
�v 
obj 
�u .corecnte****       ****
�t 
capp
�s 
bool
�r 
reco
�q 
scpt
�p 
pnam�o  �n  
�m 
pcls
�l 
ctxt
�k 
ascr
�j 
txdl
�i 
citm
�h 
optr
�g misccura�f 0 nsarray NSArray�e $0 arraywithobject_ arrayWithObject_�d  0 objectatindex_ objectAtIndex_�c 0 nsstring NSString�b 0 data  �a 0 description  �` "0 uppercasestring uppercaseString�_ &0 stringwithstring_ stringWithString_
�^ 
spac�]��� �N�M�L
�N 
errn�M�\�L  
�\ 
want
�[ 
ocid
�Z 
For_
�Y 
seld
�X .Txt:FLitnull��� ��� null�W (0 _makevalueiterator _makeValueIterator
�V kfrmID  
�U 
Scpt
�T 
Deco�S 
�R .Txt:LitR****      � ****�Q 0 etext eText� �K�J�
�K 
errn�J 0 enumber eNumber� �I�H�
�I 
erob�H 0 efrom eFrom� �G�F�E
�G 
errt�F 
0 eto eTo�E  �P �O 
0 _error  �b��^G�kv��l j 	 �kv��l j �&	 �kv��l j �&\�kv��l j  ��,%�%W 	X  �Y3��,a   s_ a ,E�Oa _ a ,FO�a -E�Oa _ a ,FO�a &E�Oa _ a ,FO�a -E�Oa _ a ,FO�a &E�O�_ a ,FOa �%a %Y ���,a   � �a a ,�k+ jk+ E�Oa a ,�j+  j+ !j+ "k+ #a &E�O_ a ,E�O_ $_ a ,FO�a -E�Oa %_ a ,FO�a &[a \[Zl\Za &2E�O�_ a ,FW X  a 'E�Oa (�%a )%Y  �a &W X  *hY hO�kv��l j	 ��&a +,a , �& b C�j+ !a &E�O�a -	 	�a .�& �[a \[Zl\Za &2E�Y hOa /�%a 0%W X  a 1*a 2��&a 3,l 4%Y hO .*�kvk+ 5E�O*�b  a 60 *a 7�a 8fa 9 :UW X  a ;W X < =*a >����a ?+ @V �D��C�B���A
�D .Txt:FTxtnull���     ctxt�C 0 templatetext templateText�B �@�?�>
�@ 
Usin�? 0 	thevalues 	theValues�>  � �=�<�;�:�9�8�7�6�5�4�3�2�1�0�/�.�-�= 0 templatetext templateText�< 0 	thevalues 	theValues�; 
0 regexp  �: 0 
asocstring 
asocString�9  0 asocmatcharray asocMatchArray�8 0 resulttexts resultTexts�7 0 
startindex 
startIndex�6 0 i  �5 0 
matchrange 
matchRange�4 0 thetoken theToken�3 0 theitem theItem�2 0 oldtids oldTIDs�1 0 
resulttext 
resultText�0 0 etext eText�/ 0 enumber eNumber�. 0 efrom eFrom�- 
0 eto eTo� $�,�+�*��)�(�'�&�%�$���#�"�!� ���;�����������������, "0 aslistparameter asListParameter
�+ misccura�* *0 nsregularexpression NSRegularExpression
�) 
msng�( Z0 +regularexpressionwithpattern_options_error_ +regularExpressionWithPattern_options_error_�' 0 nsstring NSString�& &0 stringwithstring_ stringWithString_�% 
0 length  �$ @0 matchesinstring_options_range_ matchesInString_options_range_�# 	0 count  �"  0 objectatindex_ objectAtIndex_�! 0 rangeatindex_ rangeAtIndex_�  0 location  � � *0 substringwithrange_ substringWithRange_
� 
ctxt
� 
cobj
� 
cha 
� 
long�  � ���
� 
errn��\�  
� 
For_
� .Txt:FLitnull��� ��� null� *0 substringfromindex_ substringFromIndex_
� 
ascr
� 
txdl� 0 etext eText� ���
� 
errn� 0 enumber eNumber� ��
�
� 
erob�
 0 efrom eFrom� �	��
�	 
errt� 
0 eto eTo�  � � 
0 _error  �A4b  �k+  E�O��,�j�m+ E�O��,�k+ E�O��jj�j+ lvm+ 	E�OjvE�OjE�O�� � �j�j+ kkh ��k+ jk+ E�O���j+ �a k+ a &�6FO��k+ a &E�O�a   	��6FY 3�a �a i/a &/E�O �a &�6FW X  *a �l �6FO�j+ �j+ E�[OY�vO��k+ a &�6FO_ a ,E�Oa _ a ,FO�a &E�O�_ a ,FO�VW X   *a !���] a "+ # �������
� .Txt:LLocnull��� ��� null�  �  �  � ��� �����
� misccura� 0 nslocale NSLocale�  80 availablelocaleidentifiers availableLocaleIdentifiers�� 60 sortedarrayusingselector_ sortedArrayUsingSelector_
�� 
list� ��,j+ �k+ �& �����������
�� .Txt:CLocnull��� ��� null��  ��  �  � ����������
�� misccura�� 0 nslocale NSLocale�� 0 currentlocale currentLocale�� $0 localeidentifier localeIdentifier
�� 
ctxt�� ��,j+ j+ �&ascr  ��ޭ
FasdUAS 1.101.10   ��   ��    k             x     �� ����    4     �� 
�� 
scpt  m     	 	 � 
 
  T e s t T o o l s��        x    �� ����    2   ��
�� 
osax��        l     ��������  ��  ��        l          x    $�� ����    4   	 �� 
�� 
scpt  m       �    N u m b e r��      the script being tested     �   0   t h e   s c r i p t   b e i n g   t e s t e d      l     ��������  ��  ��        l     ��������  ��  ��        l     ��������  ��  ��       !   h   $ +�� "�� 20 suite_parseformatnumber suite_ParseFormatNumber " k       # #  $ % $ l     ��������  ��  ��   %  & ' & l     �� ( )��   ( � � `canonical number format` (default) option is designed to mimic AS code's own canonical number formatting, except that NSNumberFormatter doesn't include a "+" symbol before exponent    ) � * *l   ` c a n o n i c a l   n u m b e r   f o r m a t `   ( d e f a u l t )   o p t i o n   i s   d e s i g n e d   t o   m i m i c   A S   c o d e ' s   o w n   c a n o n i c a l   n u m b e r   f o r m a t t i n g ,   e x c e p t   t h a t   N S N u m b e r F o r m a t t e r   d o e s n ' t   i n c l u d e   a   " + "   s y m b o l   b e f o r e   e x p o n e n t '  + , + l     ��������  ��  ��   ,  - . - l     �� / 0��   / � � note that these tests only check that AS wrapper around NSNumberFormatter is working as intended, not that NSNumberFormatter returns results that are appropriate, or even correct    0 � 1 1f   n o t e   t h a t   t h e s e   t e s t s   o n l y   c h e c k   t h a t   A S   w r a p p e r   a r o u n d   N S N u m b e r F o r m a t t e r   i s   w o r k i n g   a s   i n t e n d e d ,   n o t   t h a t   N S N u m b e r F o r m a t t e r   r e t u r n s   r e s u l t s   t h a t   a r e   a p p r o p r i a t e ,   o r   e v e n   c o r r e c t .  2 3 2 l     ��������  ��  ��   3  4 5 4 i     6 7 6 I      �������� 60 test_formatnumber_integer test_formatNumber_integer��  ��   7 k     � 8 8  9 : 9 I     ;�� < ; z�� 
�� .���:AsRenull��� ��� null��   < �� = >
�� 
Valu = l  	  ?���� ? I  	  @ A�� @ z�� 
�� .Mth:FNumnull���     nmbr A m    ����  ��  ��  ��   > �� B��
�� 
Equa B m     C C � D D  0��   :  E F E I   ; G�� H G z�� 
�� .���:AsRenull��� ��� null��   H �� I J
�� 
Valu I l  ' 4 K���� K I  ' 4 L M�� L z�� 
�� .Mth:FNumnull���     nmbr M m   . /���� ��  ��  ��   J �� N��
�� 
Equa N m   5 6 O O � P P  1��   F  Q R Q I  < a S�� T S z�� 
�� .���:AsRenull��� ��� null��   T �� U V
�� 
Valu U l  E R W���� W I  E R X Y�� X z�� 
�� .Mth:FNumnull���     nmbr Y m   L M���� �����  ��  ��   V �� Z [
�� 
Equa Z m   S T \ \ � ] ]  - 1 2 3 4 5 6 [ �� ^��
�� 
Summ ^ m   W Z _ _ � ` ` � f o r   ` c a n o n i c a l   n u m b e r   f o r m a t ` ,   i n t e g e r s   s h o u l d   a p p e a r   e x a c t l y   t h e   s a m e   a s   i n   A S��   R  a b a I  b � c�� d c z�� 
�� .���:AsRenull��� ��� null��   d �� e f
�� 
Valu e l  m � g���� g I  m � h i�� h z�� 
�� .Mth:FNumnull���     nmbr i l  v � j���� j c   v � k l k \   v } m n m a   v { o p o m   v w����  p m   w z����  n m   { |����  l m   } ���
�� 
long��  ��  ��  ��  ��   f �� q r
�� 
Equa q m   � � s s � t t  5 3 6 8 7 0 9 1 1 r �� u��
�� 
Summ u m   � � v v � w w p c h e c k   m a x   i n t e g e r   ( A S   i n t s   a r e   3 0   b y t e s ,   i n c l u d i n g   s i g n )��   b  x�� x I  � � y�� z y z�� 
�� .���:AsRenull��� ��� null��   z �� { |
�� 
Valu { l  � � }���� } I  � � ~ �� ~ z�� 
�� .Mth:FNumnull���     nmbr  l  � � ����� � c   � � � � � a   � � � � � m   � ������� � m   � �����  � m   � ���
�� 
long��  ��  ��  ��  ��   | �� � �
�� 
Equa � m   � � � � � � �  - 5 3 6 8 7 0 9 1 2 � �� ���
�� 
Summ � m   � � � � � � � " c h e c k   m i n   i n t e g e r��  ��   5  � � � l     ��������  ��  ��   �  � � � i    � � � I      �������� >0 test_formatnumber_realdecimal test_formatNumber_realDecimal��  ��   � k     � �  � � � I     ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  	  ����� � I  	  � ��� � z�� 
�� .Mth:FNumnull���     nmbr � m     � �         ��  ��  ��   � �� ���
�� 
Equa � m     � � � � �  0 . 0��   �  � � � I   ? ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  ' 4 ����� � I  ' 4 � ��� � z�� 
�� .Mth:FNumnull���     nmbr � m   . / � � ?�      ��  ��  ��   � �� � �
�� 
Equa � m   5 6 � � � � �  1 . 0 � �� ���
�� 
Summ � m   7 8 � � � � � � w h e n   f o r m a t t i n g   r e a l s ,   ` c a n o n i c a l   n u m b e r   f o r m a t `   m i m i c s   A S ,   s w i t c h i n g   f r o m   d e c i m a l   t o   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y��   �  � � � I  @ k ��� � � z�� 
�� .���:AsRenull��� ��� null��   � �� � �
�� 
Valu � l  K \ ���~ � I  K \ � ��} � z�| 
�| .Mth:FNumnull���     nmbr � m   T W � � �(���
=q�}  �  �~   � �{ � �
�{ 
Equa � m   ] ` � � � � �  - 1 2 . 3 4 5 � �z ��y
�z 
Summ � m   a d � � � � � � w h e n   f o r m a t t i n g   r e a l s ,   ` c a n o n i c a l   n u m b e r   f o r m a t `   m i m i c s   A S ,   s w i t c h i n g   f r o m   d e c i m a l   t o   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y�y   �  � � � I  l � ��x � � z�w 
�w .���:AsRenull��� ��� null�x   � �v � �
�v 
Valu � l  w � ��u�t � I  w � � ��s � z�r 
�r .Mth:FNumnull���     nmbr � m   � � � � @$      �s  �u  �t   � �q ��p
�q 
Equa � m   � � � � � � �  1 0 . 0�p   �  � � � I  � � ��o � � z�n 
�n .���:AsRenull��� ��� null�o   � �m � �
�m 
Valu � l  � � ��l�k � I  � � � ��j � z�i 
�i .Mth:FNumnull���     nmbr � m   � � � � @Y      �j  �l  �k   � �h ��g
�h 
Equa � m   � � � � � � � 
 1 0 0 . 0�g   �  � � � I  � � ��f � � z�e 
�e .���:AsRenull��� ��� null�f   � �d � �
�d 
Valu � l  � � ��c�b � I  � � � ��a � z�` 
�` .Mth:FNumnull���     nmbr � m   � � � � @�@     �a  �c  �b   � �_ ��^
�_ 
Equa � m   � � � � � � �  1 0 0 0 . 0�^   �  ��] � I  � ��\ � � z�[ 
�[ .���:AsRenull��� ��� null�\   � �Z � �
�Z 
Valu � l  � � ��Y�X � I  � � � ��W � z�V 
�V .Mth:FNumnull���     nmbr � m   � � � � @^�/��w�W  �Y  �X   � �U ��T
�U 
Equa � m   � � � � � � �  1 2 3 . 4 5 6�T  �]   �  � � � l     �S�R�Q�S  �R  �Q   �  � � � i    � � � I      �P�O�N�P D0  test_formatnumber_realscientific  test_formatNumber_realScientific�O  �N   � k     � � �  � � � I     ��M � � z�L 
�L .���:AsRenull��� ��� null�M   � �K 
�K 
Valu  l  	 �J�I I  	 �H z�G 
�G .Mth:FNumnull���     nmbr m     @È     �H  �J  �I   �F
�F 
Equa m     �		 
 1 . 0 E 4 �E
�D
�E 
Summ
 m     � � u n l i k e   A S ,   N S N u m b e r F o r m a t t e r   d o e s n ' t   i n c l u d e   ' + '   b e f o r e   e x p o n e n t�D   �  I    ?�C z�B 
�B .���:AsRenull��� ��� null�C   �A
�A 
Valu l  ) 6�@�? I  ) 6�> z�= 
�= .Mth:FNumnull���     nmbr m   0 1 A��e    �>  �@  �?   �<�;
�< 
Equa m   7 8 � 
 1 . 0 E 9�;    I  @ i�: z�9 
�9 .���:AsRenull��� ��� null�:   �8
�8 
Valu l  K \ �7�6  I  K \!"�5! z�4 
�4 .Mth:FNumnull���     nmbr" m   T W## Ag�)�   �5  �7  �6   �3$%
�3 
Equa$ m   ] `&& �''  1 . 2 3 4 5 6 7 8 E 7% �2(�1
�2 
Summ( m   a d)) �** � d e f a u l t   f o r m a t   s w i t c h e s   b e t w e e n   d e c i m a l   a n d   s c i e n t i f i c   n o t a t i o n   a u t o m a t i c a l l y�1   +,+ I  j �-�0.- z�/ 
�/ .���:AsRenull��� ��� null�0  . �./0
�. 
Valu/ l  u �1�-�,1 I  u �23�+2 z�* 
�* .Mth:FNumnull���     nmbr3 m   ~ �44 �n���Y�+  �-  �,  0 �)5�(
�) 
Equa5 m   � �66 �77  1 . 0 E - 3 0 0�(  , 898 I  � �:�';: z�& 
�& .���:AsRenull��� ��� null�'  ; �%<=
�% 
Valu< l  � �>�$�#> I  � �?@�"? z�! 
�! .Mth:FNumnull���     nmbr@ m   � �AA ��t���\��"  �$  �#  = � B�
�  
EquaB m   � �CC �DD  - 1 . 2 3 4 5 E - 3 0 0�  9 E�E I  � �F�GF z� 
� .���:AsRenull��� ��� null�  G �HI
� 
ValuH l  � �J��J I  � �KL�K z� 
� .Mth:FNumnull���     nmbrL m   � �MM A�e���  �  �  �  I �N�
� 
EquaN m   � �OO �PP  1 . 2 3 4 5 6 7 8 9 E 9�  �   � QRQ l     ����  �  �  R STS l     ����  �  �  T UVU i   WXW I      ���� @0 test_formatnumber_customformat test_formatNumber_customFormat�  �  X k    �YY Z[Z I    \�]\ z�
 
�
 .���:AsRenull��� ��� null�  ] �	^_
�	 
Valu^ l  	 `��` I  	 abca z� 
� .Mth:FNumnull���     nmbrb m    dd A�e���  c �e�
� 
Usine m    ff z� 
� MthZMth2�  �  �  _ �g�
� 
Equag l   h� ��h m    ii �jj  1 , 2 3 4 , 5 6 7 , 8 9 0�   ��  �  [ klk I    Bm��nm z�� 
�� .���:AsRenull��� ��� null��  n ��op
�� 
Valuo l  ) ;q����q I  ) ;rstr z�� 
�� .Mth:FNumnull���     nmbrs m   0 1uu A�e���  t ��v��
�� 
Usinv K   2 6ww xy��x z�� 
�� 
MthAy m   3 4zz z�� 
�� MthZMth2��  ��  ��  ��  p ��{��
�� 
Equa{ l  < =|����| m   < =}} �~~  1 , 2 3 4 , 5 6 7 , 8 9 0��  ��  ��  l � I  C q����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  N h������ I  N h���� z�� 
�� .Mth:FNumnull���     nmbr� m   W X�� A�e���  � �����
�� 
Usin� K   Y c�� ���� z�� 
�� 
MthA� m   Z [�� z�� 
�� MthZMth2� ����� z�� 
�� 
MthG� m   ^ a�� ���  ��  ��  ��  ��  � �����
�� 
Equa� l  i l������ m   i l�� ���  1 2 3 4 5 6 7 8 9 0��  ��  ��  � ��� I  r ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  } ������� I  } ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   � ��� ���� z�� 
�� 
MthA� m   � ��� z�� 
�� MthZMth2� ���� z�� 
�� 
MthG� m   � ��� ���  � ����� z�� 
�� 
MthE� m   � ����� ��  ��  ��  ��  � �����
�� 
Equa� l  � ������� m   � ��� ���  1 2 3 0 0 0 0 0 0 0��  ��  ��  � ��� I  � ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  � ������� I  � ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   � ��� ���� z�� 
�� 
MthA� m   � ��� z�� 
�� MthZMth2� ���� z�� 
�� 
MthG� m   � ��� ���  � ����� z�� 
�� 
MthB� m   � ����� ��  ��  ��  ��  � �����
�� 
Equa� l  � ������� m   � ��� ���  1 2 3 4 5 6 7 8 9 0 . 0 0 0��  ��  ��  � ��� I  ������ z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  ������� I  ����� z�� 
�� .Mth:FNumnull���     nmbr� m   � ��� A�e���  � �����
�� 
Usin� K   ��� ���� z�� 
�� 
MthA� m   � ��� z�� 
�� MthZMth2� ���� z�� 
�� 
MthG� m   � ��� ���  � ���� z�� 
�� 
MthE� m   � ����� � ����� z�� 
�� 
MthB� m  ���� ��  ��  ��  ��  � ����
�� 
Equa� l ������ m  �� ���  1 2 3 0 0 0 0 0 0 0��  ��  � �����
�� 
Summ� m  �� ��� � N S N u m b e r F o r m a t t e r   a p p e a r s   t o   o v e r r i d e   m i n i m u m F r a c t i o n D i g i t s   w h e n   s i g n i f i c a n t   d i g i t s   a r e   u s e d��  � ��� I _����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l (N������ I (N���� z�� 
�� .Mth:FNumnull���     nmbr� m  14�� @(���$բ� �����
�� 
Usin� K  5I��    z�� 
�� 
MthA m  67 z�� 
�� MthZMth2  z�� 
�� 
MthG m  := �   	
	 z�� 
�� 
MthE
 m  @A����  �� z�� 
�� 
MthB m  DE���� ��  ��  ��  ��  � ��
�� 
Equa l OR���� m  OR �  1 2 . 3��  ��   ����
�� 
Summ m  UX � � N S N u m b e r F o r m a t t e r   a p p e a r s   t o   o v e r r i d e   m i n i m u m F r a c t i o n D i g i t s   w h e n   s i g n i f i c a n t   d i g i t s   a r e   u s e d��  �  I `��� z�� 
�� .���:AsRenull��� ��� null��   ��
�� 
Valu l k����� I k� z�� 
�� .Mth:FNumnull���     nmbr m  tw   >��#��q ��!��
�� 
Usin! K  x�"" #$%# z�� 
�� 
MthA$ m  yz&& z�� 
�� MthZMth2% '(��' z�� 
�� 
MthE( m  }~���� ��  ��  ��  ��   ��)��
�� 
Equa) l ��*����* m  ��++ �,,  0 . 0 0 0 0 0 1 2 3��  ��  ��   -��- I ��.�/. z�~ 
�~ .���:AsRenull��� ��� null�  / �}01
�} 
Valu0 l ��2�|�{2 I ��3453 z�z 
�z .Mth:FNumnull���     nmbr4 m  ��66 >��#��q5 �y7�x
�y 
Usin7 K  ��88 9:;9 z�w 
�w 
MthA: m  ��<< z�v 
�v MthZMth2; =>?= z�u 
�u 
MthE> m  ���t�t ? @A�s@ z�r 
�r 
MthHA m  ��BB z�q 
�q MRndRN_F�s  �x  �|  �{  1 �pC�o
�p 
EquaC l ��D�n�mD m  ��EE �FF  0 . 0 0 0 0 0 1 2 4�n  �m  �o  ��  V GHG l     �l�k�j�l  �k  �j  H IJI l     �i�h�g�i  �h  �g  J KLK i   M�fM I      �e�d�c�e >0 test_parsenumber_customformat test_parseNumber_customFormat�d  �c  �f  L NON l     �b�a�`�b  �a  �`  O PQP l     �_�^�]�_  �^  �]  Q RSR l     �\�[�Z�\  �[  �Z  S TUT i   VWV I      �Y�X�W�Y 40 test_formatnumber_locale test_formatNumber_locale�X  �W  W k     �XX YZY I    [�V\[ z�U 
�U .���:AsRenull��� ��� null�V  \ �T]^
�T 
Valu] l  	 _�S�R_ I  	 `a�Q` z�P 
�P .Mth:FNumnull���     nmbra m    bb @	�Q��Q  �S  �R  ^ �Ocd
�O 
Equac m    ee �ff  3 . 1 4d �Ng�M
�N 
Summg m    hh �ii
 u n l i k e   A S ' s   t e x t - n u m b e r   c o e r c i o n s ,   w h i c h   a r e   l o c a l e - d e p e n d e n t ,   b a s i c   f o r m a t t i n g   s h o u l d   i g n o r e   l o c a l e   a n d   a l w a y s   u s e   p e r i o d   s e p a r a t o r s�M  Z jkj I    El�Lml z�K 
�K .���:AsRenull��� ��� null�L  m �Jno
�J 
Valun l  ) 8p�I�Hp I  ) 8qrsq z�G 
�G .Mth:FNumnull���     nmbrr m   0 1tt @	�Q�s �Fu�E
�F 
Locau m   2 3vv �ww 
 d e _ D E�E  �I  �H  o �Dxy
�D 
Equax m   9 <zz �{{  3 , 1 4y �C|�B
�C 
Summ| m   = @}} �~~ n G e r m a n y   u s e s   c o m m a s ,   n o t   p e r i o d s ,   a s   d e c i m a l   s e p a r a t o r s�B  k � I  F w��A�� z�@ 
�@ .���:AsRenull��� ��� null�A  � �?��
�? 
Valu� l  Q l��>�=� I  Q l���� z�< 
�< .Mth:FNumnull���     nmbr� m   Z [�� @	�Q�� �;��
�; 
Usin� m   ^ a�� z�: 
�: MthZMth5� �9��8
�9 
Loca� m   b e�� ��� 
 e n _ U S�8  �>  �=  � �7��6
�7 
Equa� m   m p�� ��� 
 $ 3 . 1 4�6  � ��5� I  x ���4�� z�3 
�3 .���:AsRenull��� ��� null�4  � �2��
�2 
Valu� l  � ���1�0� I  � ����� z�/ 
�/ .Mth:FNumnull���     nmbr� m   � ��� @���1��� �.��
�. 
Usin� m   � ��� z�- 
�- MthZMth5� �,��+
�, 
Loca� m   � ��� ��� 
 d e _ D E�+  �1  �0  � �*��)
�* 
Equa� m   � ��� ���  1 2 . 3 4 5 , 6 8 � ��)  �5  U ��� l     �(�'�&�(  �'  �&  � ��� l     �%�$�#�%  �$  �#  � ��� i   ��� I      �"�!� �" 20 test_parsenumber_locale test_parseNumber_locale�!  �   � k     ?�� ��� I    ���� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  	 ���� I  	 ���� z� 
� .Mth:PNumnull���     ctxt� m    �� ���  3 . 1 4�  �  �  � ���
� 
Equa� m    �� @	�Q��  � ��� I   =���� z� 
� .���:AsRenull��� ��� null�  � ���
� 
Valu� l  ' 6���� I  ' 6���� z� 
� .Mth:PNumnull���     ctxt� m   . /�� ���  3 , 1 4� ���
� 
Loca� m   0 1�� ��� 
 d e _ D E�  �  �  � ���
� 
Equa� m   7 8�� @	�Q��  � ��� l  > >��
�	�  �
  �	  �  � ��� l     ����  �  �  � ��� l     ����  �  �  �   ! ��� l     �� ���  �   ��  � ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� h   , 3����� 20 suite_generaloperations suite_GeneralOperations� k      �� ��� l     ��������  ��  ��  � ��� l     ������  �   TO DO: cmp    � ���    T O   D O :   c m p  � ��� l     ��������  ��  ��  � ��� i    ��� I      �������� $0 test_roundnumber test_roundNumber��  ��  � k     /�� ��� I    -����� z�� 
�� .���:AsRenull��� ��� null��  � ����
�� 
Valu� l  	 ������ I  	 ���� z�� 
�� .Mth:RouNnull���     nmbr� m    �� @�z�G�� �����
�� 
Plac� m    ���� ��  ��  ��  � ����
�� 
Equa� m    �� @�\(�� �����
�� 
Usin� l   (������ I   (������ z�� 
�� .���:NmEqnull��� ��� null��  ��  ��  ��  ��  � ���� l  . .������  �   TO DO: more tests   � ��� $   T O   D O :   m o r e   t e s t s��  � ���� l     ��������  ��  ��  ��  �    l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��    l     ��������  ��  ��   	 i   4 7

 I     ������
�� .aevtoappnull  �   � ****��  ��   l     I    �� z�� 
�� .���:RunTnull���     file l   ���� I   ����
�� .earsffdralis        afdr  f    ��  ��  ��  ��   N H including this command allows tests to be run directly in Script Editor    � �   i n c l u d i n g   t h i s   c o m m a n d   a l l o w s   t e s t s   t o   b e   r u n   d i r e c t l y   i n   S c r i p t   E d i t o r	  l     ��������  ��  ��    l     ��������  ��  ��   �� l     ��������  ��  ��  ��       ����   ��������
�� 
pimr�� 20 suite_parseformatnumber suite_ParseFormatNumber�� 20 suite_generaloperations suite_GeneralOperations
�� .aevtoappnull  �   � **** ����    ! ��"��
�� 
cobj" ##   �� 	
�� 
scpt��    ��$��
�� 
cobj$ %%   ��
�� 
osax��  ! ��&��
�� 
cobj& ''   �� 
�� 
scpt��   �� "  (�� 20 suite_parseformatnumber suite_ParseFormatNumber( 	��)*+,-./0��  ) ���������������� 60 test_formatnumber_integer test_formatNumber_integer�� >0 test_formatnumber_realdecimal test_formatNumber_realDecimal�� D0  test_formatnumber_realscientific  test_formatNumber_realScientific�� @0 test_formatnumber_customformat test_formatNumber_customFormat�� >0 test_parsenumber_customformat test_parseNumber_customFormat�� 40 test_formatnumber_locale test_formatNumber_locale�� 20 test_parsenumber_locale test_parseNumber_locale* �� 7����12���� 60 test_formatnumber_integer test_formatNumber_integer��  ��  1  2 �� 	�� ���� C���� 	  O 	 �� \�� _�� 	 ���� s v 	 �� � �
�� 
scpt
�� 
Valu
�� .Mth:FNumnull���     nmbr
�� 
Equa�� 
�� .���:AsRenull��� ��� null�� ���
�� 
Summ�� �� 
�� 
long������ �)��/ *�)��/ jj U��� UO)��/ *�)��/ kj U��� UO)��/ *�)��/ �j U��a a a  UO)�a / -*�)�a / la $ka &j U�a a a a  UO)�a / -*�)�a / a a $a &j U�a a a a  U+ �� �����34���� >0 test_formatnumber_realdecimal test_formatNumber_realDecimal��  ��  3  4 &�� 	��  ����� ����� 	  � ��� ��� 	  � � � 	  � � 	  � � 	  � � 	  � �
�� 
scpt
�� 
Valu
�� .Mth:FNumnull���     nmbr
�� 
Equa�� 
�� .���:AsRenull��� ��� null
�� 
Summ�� ��)��/ *�)��/ �j U��� 	UO)��/ *�)��/ �j U����a  	UO)�a / #*�)�a / 	a j U�a �a a  	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a j U�a � 	UO)�a / *�)�a / 	a  j U�a !� 	UO)�a "/ *�)�a #/ 	a $j U�a %� 	U, �� �����56���� D0  test_formatnumber_realscientific  test_formatNumber_realScientific��  ��  5  6 "� 	�~ �}�|�{�z�y 	 �x 	 #&) 	 46 	 AC 	 MO
� 
scpt
�~ 
Valu
�} .Mth:FNumnull���     nmbr
�| 
Equa
�{ 
Summ�z 
�y .���:AsRenull��� ��� null�x �� �)��/ *�)��/ �j U����� UO)��/ *�)��/ �j U��a  UO)�a / !*�)�a / 	a j U�a �a � UO)�a / *�)�a / 	a j U�a a  UO)�a / *�)�a / 	a j U�a a  UO)�a / *�)�a / 	a  j U�a !a  U- �wX�v�u78�t�w @0 test_formatnumber_customformat test_formatNumber_customFormat�v  �u  7  8 6�s 	�r d�q�p�o�ni�m�l 	 �k} 	 �j�� 	 ��i�h� 	 ��g� 	 ��f��e� 	 � 	  + 	 �d�cE
�s 
scpt
�r 
Valu
�q 
Usin
�p MthZMth2
�o .Mth:FNumnull���     nmbr
�n 
Equa�m 
�l .���:AsRenull��� ��� null
�k 
MthA
�j 
MthG
�i 
MthE�h 
�g 
MthB�f 
�e 
Summ
�d 
MthH
�c MRndRN_F�t�)��/ *�)��/ 	���l U��� UO)��/ *�)��/ ����ll U��� UO)�a / &*�)�a / ����a a �l U�a � UO)�a / ,*�)�a / ����a a a ma l U�a � UO)�a / ,*�)�a / ����a a a ma l U�a � UO)�a  / 8*�)�a !/ ����a a "a ma ma #l U�a $a %a &a  UO)�a '/ :*�)�a (/ a )���a a *a ma ma #l U�a +a %a ,a  UO)�a -/ &*�)�a ./ a /���a m�l U�a 0� UO)�a 1/ .*�)�a 2/ a /���a ma 3a 4a l U�a 5� U. �b�a�`�_9:�^�b >0 test_parsenumber_customformat test_parseNumber_customFormat�a  �`  �_  9  :  �^ h/ �]W�\�[;<�Z�] 40 test_formatnumber_locale test_formatNumber_locale�\  �[  ;  < �Y 	�X b�W�Ve�Uh�T�S 	 �Rvz} 	 �Q�P��O� 	 ���
�Y 
scpt
�X 
Valu
�W .Mth:FNumnull���     nmbr
�V 
Equa
�U 
Summ�T 
�S .���:AsRenull��� ��� null
�R 
Loca
�Q 
Usin
�P MthZMth5�O �Z �)��/ *�)��/ �j U����� UO)��/ *�)��/ 	���l U�a �a � UO)�a / )*�)�a / �a a �a a  U�a a  UO)�a / +*�)�a / a a a �a a  U�a a  U0 �N��M�L=>�K�N 20 test_parsenumber_locale test_parseNumber_locale�M  �L  =  > �J 	�I ��H�G��F�E 	 ��D�
�J 
scpt
�I 
Valu
�H .Mth:PNumnull���     ctxt
�G 
Equa�F 
�E .���:AsRenull��� ��� null
�D 
Loca�K @)��/ *�)��/ �j U��� 	UO)��/ *�)��/ 	���l U��� 	UOP �C�  ?�C 20 suite_generaloperations suite_GeneralOperations? �B@A�B  @ �A�A $0 test_roundnumber test_roundNumberA �@��?�>BC�=�@ $0 test_roundnumber test_roundNumber�?  �>  B  C �< 	�; ��:�9�8��7 	�6�5�4
�< 
scpt
�; 
Valu
�: 
Plac
�9 .Mth:RouNnull���     nmbr
�8 
Equa
�7 
Usin
�6 .���:NmEqnull��� ��� null�5 
�4 .���:AsRenull��� ��� null�= 0)��/ '*�)��/ 	��ll U���)��/ *j U� UOP �3�2�1DE�0
�3 .aevtoappnull  �   � ****�2  �1  D  E �/ 	�.�-
�/ 
scpt
�. .earsffdralis        afdr
�- .���:RunTnull���     file�0 )��/ )j j U ascr  ��ޭ
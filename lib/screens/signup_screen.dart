import 'package:flutter/material.dart';

class signup_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Create an account to get started',
              style: TextStyle(
                color: Color(0xFF71727A),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            _buildInputField('아이디', '문자 또는 숫자 4~64자'),
            const SizedBox(height: 16),
            _buildInputField('이메일 주소', 'name@email.com'),
            const SizedBox(height: 16),
            _buildPasswordField('비밀번호', '영문 대소문자, 숫자 포함 8자 이상'),
            const SizedBox(height: 16),
            _buildPasswordField('비밀번호 확인', '비밀번호 재입력'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // 다음으로 버튼 클릭 시 login_screen으로 이동
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4FA55B),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Center(
                  child: Text(
                    '다음으로',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  '이미 계정이 있으신가요? 로그인',
                  style: TextStyle(
                    color: Color(0xFF4FA55B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(String label, String hint) {
    return _buildInputField(label, hint);
  }
}

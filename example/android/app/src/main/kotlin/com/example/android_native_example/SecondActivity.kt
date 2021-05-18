package com.example.android_native_example

import android.content.Intent
import android.app.Activity
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button

class SecondActivity : AppCompatActivity() {
  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    setContentView(R.layout.activity_second)
    
    val btnFinish = findViewById<Button>(R.id.btnFinish)

    btnFinish.setOnClickListener {
      setResult(Activity.RESULT_OK, Intent().apply { putExtra("value", "Hello World!") })
      finish()
    }
  }
}
